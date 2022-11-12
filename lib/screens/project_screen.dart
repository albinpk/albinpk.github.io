import 'dart:math';

import 'package:flutter/material.dart';

import '../constants.dart';
import '../data/projects.dart';
import '../models/project_model.dart';
import '../views/project_view.dart';

final _random = Random();

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({
    super.key,
    required this.projectIndex,
    required this.backgroundColor,
    required this.heroTag,
    required this.animation,
  });

  /// The index of a project in [projects].
  final int projectIndex;

  /// The Scaffold background color.
  final Color backgroundColor;

  /// Hero tag for Text widget.
  final Object heroTag;

  /// Page transition animation
  final Animation<double> animation;

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  );

  /// Animation for AppBar content (backButton, title). First 40%.
  late final _intervalAnimation = CurvedAnimation(
    parent: _animationController,
    curve: const Interval(0, 0.4, curve: Curves.ease),
  );

  /// Slide from top to bottom.
  late final _backButtonAnimation = Tween<Offset>(
    begin: const Offset(0, -1),
    end: Offset.zero,
  ).animate(_intervalAnimation);

  /// Fade in
  late final _titleAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(_intervalAnimation);

  @override
  void initState() {
    super.initState();
    widget.animation.addStatusListener(_animationStatusListener);
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    widget.animation.removeStatusListener(_animationStatusListener);
    _animationController.dispose();
    super.dispose();
  }

  /// The project.
  late final Project _project = projects[widget.projectIndex];

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: widget.backgroundColor,
        elevation: 0,
        leading: SlideTransition(
          position: _backButtonAnimation,
          child: const BackButton(),
        ),
        title: FadeTransition(
          opacity: _titleAnimation,
          child: Text(_project.title),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Project
          Expanded(
            child: ProjectView(
              projectIndex: widget.projectIndex,
              animation: _animationController,
            ),
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
                    children: kMyName.characters.map((char) {
                      return Hero(
                        tag: kMyName[widget.projectIndex] == char
                            ? widget.heroTag
                            : _random.nextDouble(),
                        child: kMyName[widget.projectIndex] == char
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
