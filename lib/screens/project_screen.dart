import 'dart:math';

import 'package:flutter/material.dart';

import '../data/projects.dart';
import '../views/project_view.dart';

final _random = Random();

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({
    super.key,
    required this.backgroundColor,
    required this.heroTag,
    required this.animation,
  });

  /// The Scaffold background color.
  final Color backgroundColor;

  /// Hero tag for Text widget.
  final String heroTag;

  /// Page transition animation
  final Animation<double> animation;

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen>
    with SingleTickerProviderStateMixin {
  late final _backButtonAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late final _backButtonAnimation = Tween<Offset>(
    begin: const Offset(0, -1),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _backButtonAnimationController,
    curve: Curves.ease,
  ));

  @override
  void initState() {
    super.initState();
    widget.animation.addStatusListener(_animationStatusListener);
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _backButtonAnimationController.forward();
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.animation.removeStatusListener(_animationStatusListener);
    _backButtonAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final smallTextStyle = Theme.of(context).textTheme.titleSmall!.copyWith(
          color: Colors.white,
        );
    final largeTextStyle = Theme.of(context).textTheme.displayMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: widget.backgroundColor,
        );

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Back button
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                SlideTransition(
                  position: _backButtonAnimation,
                  child: const BackButton(color: Colors.white),
                ),
              ],
            ),
          ),

          // Project
          Expanded(
            child: ProjectView(project: projects.first),
          ),

          // Made by ALBIN text
          DefaultTextStyle(
            style: smallTextStyle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Made by '),
                  Row(
                    children: 'ALBIN PK'.characters.map((char) {
                      return Hero(
                        tag: widget.heroTag[0] == char
                            ? widget.heroTag
                            : _random.nextDouble(),
                        child: widget.heroTag[0] == char
                            // Changing the font size and color of the
                            // hero text during the forward page transition.
                            ? AnimatedBuilder(
                                animation: widget.animation,
                                builder: (context, _) {
                                  return Text(
                                    char,
                                    style: widget.animation.status ==
                                            AnimationStatus.reverse
                                        ? null
                                        : TextStyleTween(
                                            begin: largeTextStyle,
                                            end: smallTextStyle,
                                          ).evaluate(CurvedAnimation(
                                            parent: widget.animation,
                                            curve: Curves.ease,
                                          )),
                                  );
                                },
                              )
                            : Text(char),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
