import 'dart:developer';
import 'dart:math' hide log;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants.dart';
import '../data/projects.dart';
import '../models/project_model.dart';
import '../views/project_view.dart';
import '../widgets/supported_platforms_chip.dart';

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

  /// Animation for AppBar content (backButton, title, action buttons). First 40%.
  late final _intervalAnimation = CurvedAnimation(
    parent: _animationController,
    curve: const Interval(0, 0.4, curve: Curves.ease),
  );

  /// Slide from top to bottom.
  late final _backButtonAnimation = Tween<Offset>(
    begin: const Offset(0, -1),
    end: Offset.zero,
  ).animate(_intervalAnimation);

  /// Fade in.
  late final _fadeInAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(_intervalAnimation);

  /// Slide from right to left.
  late final _buttonAnimation = Tween<Offset>(
    begin: const Offset(1, 0),
    end: Offset.zero,
  ).animate(_intervalAnimation);

  @override
  void initState() {
    super.initState();
    widget.animation.addStatusListener(_animationStatusListener);
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController.forward();
      // Disabling reverse Hero animation
      setState(() {
        _heroTagAfterAnimation = 1; // 1 is not included in Random.nextDouble()
      });
    }
  }

  /// This tag is applied to the Hero widget (in "Made by ALBIN.." text) after the
  /// route animation has finished in order to disable the reverse Hero animation.
  Object? _heroTagAfterAnimation;

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

    return ColoredBox(
      color: widget.backgroundColor,
      child: Center(
        child: SizedBox(
          width: 1600,
          child: Scaffold(
            backgroundColor: widget.backgroundColor,
            appBar: _AppBar(
              backgroundColor: widget.backgroundColor,
              backButtonAnimation: _backButtonAnimation,
              fadeInAnimation: _fadeInAnimation,
              buttonAnimation: _buttonAnimation,
              project: _project,
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
                                  ? _heroTagAfterAnimation ?? widget.heroTag
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
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    Key? key,
    required this.backgroundColor,
    required this.backButtonAnimation,
    required this.fadeInAnimation,
    required this.buttonAnimation,
    required this.project,
  }) : super(key: key);

  final Color backgroundColor;
  final Animation<Offset> backButtonAnimation;
  final Animation<double> fadeInAnimation;
  final Animation<Offset> buttonAnimation;
  final Project project;

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 700;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: SlideTransition(
        position: backButtonAnimation,
        child: const BackButton(),
      ),
      title: FadeTransition(
        opacity: fadeInAnimation,
        child: Row(
          children: [
            Text(project.title),

            // Supported platforms
            if (isLargeScreen) ...[
              const SizedBox(width: 20),
              Tooltip(
                message: 'Platforms',
                child: SupportedPlatformsChip(
                  platforms: project.platforms,
                ),
              ),
            ]
          ],
        ),
      ),
      actions: !isLargeScreen
          ? null
          : [
              // Live demo and repository button

              FadeTransition(
                opacity: fadeInAnimation,
                child: SlideTransition(
                  position: buttonAnimation,
                  child: TextButtonTheme(
                    data: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                      ),
                    ),
                    child: Row(
                      children: [
                        if (project.liveDemoUrl != null)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: TextButton(
                              onPressed: () => _launchUrl(project.liveDemoUrl!),
                              child: const Text('Live Demo'),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                          child: TextButton(
                            onPressed: () => _launchUrl(project.repoUrl),
                            child: const Text('Repository'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
    );
  }

  /// Launch given url.
  void _launchUrl(String url) async {
    if (!await launchUrlString(url)) log("Can't open url: $url!");
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
