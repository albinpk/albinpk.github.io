import 'package:flutter/material.dart';

/// Slide the page from right to left.
class SlidePageBuilder extends PageRouteBuilder {
  SlidePageBuilder({required super.pageBuilder})
      : super(transitionDuration: const Duration(milliseconds: 1000));

  @override
  RouteTransitionsBuilder get transitionsBuilder {
    return (context, animation, _, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: const Offset(0, 0),
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.ease,
        )),
        child: child,
      );
    };
  }
}
