import 'package:explore_coorg/screens/home/explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesNotifier extends ChangeNotifier {
  static const String _storageKey = 'favourite_places';

  final List<TouristPlace> _favourites = [];
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;
  List<TouristPlace> get favourites => List.unmodifiable(_favourites);

  // Called automatically when the app starts
  FavouritesNotifier() {
    _loadFromPrefs();
  }

  // Read saved names → look up full TouristPlace objects
  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> savedNames = prefs.getStringList(_storageKey) ?? [];

    for (final name in savedNames) {
      final match = allPlaces.where((p) => p.name == name).firstOrNull;
      if (match != null) _favourites.add(match);
    }

    _isLoaded = true;
    notifyListeners();
  }

  // Save current favourite names to SharedPreferences
  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _storageKey,
      _favourites.map((p) => p.name).toList(),
    );
  }

  bool isFavourite(TouristPlace place) =>
      _favourites.any((p) => p.name == place.name);

  void toggle(TouristPlace place) {
    if (isFavourite(place)) {
      _favourites.removeWhere((p) => p.name == place.name);
    } else {
      _favourites.add(place);
    }
    notifyListeners(); // rebuilds any listening widget instantly
    _saveToPrefs(); // persists to disk
  }
}

// Wraps the app so any widget can access the notifier
class FavouritesProvider extends InheritedNotifier<FavouritesNotifier> {
  const FavouritesProvider({
    super.key,
    required FavouritesNotifier notifier,
    required super.child,
  }) : super(notifier: notifier);

  static FavouritesNotifier of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<FavouritesProvider>();
    assert(provider != null, 'No FavouritesProvider found in widget tree');
    return provider!.notifier!;
  }
}
