import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'screens/home_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  /// Animation Controller for theme mode change (ripple effect).
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
    value: SchedulerBinding
                .instance.window.platformDispatcher.platformBrightness ==
            Brightness.light
        ? 0
        : 1,
  );

  /// Theme mode switch animation.
  late final _themModeAnimation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOutCubic,
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final darkTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF202123),
      textTheme: TextTheme(
        titleMedium: textTheme.titleMedium!.copyWith(color: Colors.white70),
        displaySmall: textTheme.displaySmall!.copyWith(color: Colors.white70),
      ),
    );
    final lightTheme = ThemeData.light().copyWith(
      textTheme: TextTheme(
        titleMedium: textTheme.titleMedium!.copyWith(color: Colors.black54),
        displaySmall: textTheme.displaySmall!.copyWith(color: Colors.black54),
      ),
    );

    return MaterialApp(
      title: 'Albin P K | Personal webpage',
      home: Stack(
        children: [
          // Light themed HomeScreen
          Theme(
            data: lightTheme,
            child: HomeScreen(onThemeModeChange: _onThemeModeChange),
          ),

          // Dark themed HomeScreen
          AnimatedBuilder(
            animation: _themModeAnimation,
            builder: (context, child) {
              final screenSize = MediaQuery.of(context).size;
              return ClipPath(
                clipper: CircleClipper(
                  value: _themModeAnimation.value,
                  center: Offset(screenSize.width - 40, 40), // button position
                ),
                child: child,
              );
            },
            child: Theme(
              data: darkTheme,
              child: HomeScreen(onThemeModeChange: _onThemeModeChange),
            ),
          ),
        ],
      ),
    );
  }

  void _onThemeModeChange(ThemeMode themeMode) {
    if (themeMode == ThemeMode.dark) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
}

/// Circle shaped clipper.
class CircleClipper extends CustomClipper<Path> {
  CircleClipper({
    required this.value,
    required this.center,
  });

  /// Animation value.
  final double value;

  /// The center point.
  final Offset center;

  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(
        Rect.fromCircle(
          center: center,
          radius: _getRadius(size) * value,
        ),
      );
  }

  /// Determine the longest distance between the centre point and each corner.
  double _getRadius(Size size) {
    final w = size.width, h = size.height;
    final toTopLeft = (center - Offset.zero).distanceSquared;
    final toTopRight = (center - Offset(w, 0)).distanceSquared;
    final toBottomLeft = (center - Offset(0, h)).distanceSquared;
    final toBottomRight = (center - Offset(w, h)).distanceSquared;
    return sqrt(max(
      max(toTopLeft, toTopRight),
      max(toBottomLeft, toBottomRight),
    ));
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
