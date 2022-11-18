import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      themeMode: _themeMode,
      theme: ThemeData.light().copyWith(
        textTheme: TextTheme(
          titleMedium: textTheme.titleMedium!.copyWith(color: Colors.black54),
          displaySmall: textTheme.displaySmall!.copyWith(color: Colors.black54),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF202123),
        textTheme: TextTheme(
          titleMedium: textTheme.titleMedium!.copyWith(color: Colors.white70),
          displaySmall: textTheme.displaySmall!.copyWith(color: Colors.white70),
        ),
      ),
      title: 'Albin P K | Personal webpage',
      home: HomeScreen(
        onThemeModeChange: (themeMode) {
          setState(() => _themeMode = themeMode);
        },
      ),
    );
  }
}
