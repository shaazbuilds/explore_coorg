import 'package:explore_coorg/providers/favourites_provider.dart';
import 'package:explore_coorg/splash_screen.dart';
import 'package:explore_coorg/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent bar background
    ),
  );
  runApp(const CoorgExplorerApp());
}

class CoorgExplorerApp extends StatelessWidget {
  const CoorgExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FavouritesProvider(
      // ← wrap here
      notifier: FavouritesNotifier(),
      child: MaterialApp(
        title: 'Coorg Explorer',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
      ),
    );
  }
}
