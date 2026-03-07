import 'package:explore_coorg/providers/favourites_provider.dart';
import 'package:explore_coorg/splash_screen.dart';
import 'package:explore_coorg/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://mhjuccfbygolnarckwhw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1oanVjY2ZieWdvbG5hcmNrd2h3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI4NjE4MDksImV4cCI6MjA4ODQzNzgwOX0.R03Us0FRGKmpeMd3nmohzOpGt8p3Tr6FAktYaY6DL58',
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
