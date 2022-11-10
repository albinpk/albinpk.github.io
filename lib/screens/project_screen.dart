import 'dart:math';

import 'package:flutter/material.dart';

final _random = Random();

class ProjectScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final smallTextStyle = Theme.of(context).textTheme.titleSmall!.copyWith(
          color: Colors.white,
        );
    final largeTextStyle = Theme.of(context).textTheme.displayMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: backgroundColor,
        );

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Back button
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: const [
                BackButton(color: Colors.white),
              ],
            ),
          ),

          // Project
          const Spacer(),

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
                    children: 'ALBIN PK'.characters.map((c) {
                      return Hero(
                        tag: heroTag[0] == c ? heroTag : _random.nextDouble(),
                        child: heroTag[0] == c
                            // Changing the font size and color of the
                            // hero text during the forward page transition.
                            ? AnimatedBuilder(
                                animation: animation,
                                builder: (context, _) {
                                  return Text(
                                    c,
                                    style: animation.status ==
                                            AnimationStatus.reverse
                                        ? null
                                        : TextStyleTween(
                                            begin: largeTextStyle,
                                            end: smallTextStyle,
                                          ).evaluate(CurvedAnimation(
                                            parent: animation,
                                            curve: Curves.ease,
                                          )),
                                  );
                                },
                              )
                            : Text(c),
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
