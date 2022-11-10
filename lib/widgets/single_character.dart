import 'dart:math';

import 'package:flutter/material.dart';

import '../core/slide_page_builder.dart';
import '../screens/project_screen.dart';

class SingleCharacter extends StatefulWidget {
  const SingleCharacter(this.char, {super.key});

  final String char;

  @override
  State<SingleCharacter> createState() => _SingleCharacterState();
}

class _SingleCharacterState extends State<SingleCharacter> {
  late final _textSmall = Theme.of(context).textTheme.displaySmall!;
  late final _textLarge = Theme.of(context).textTheme.displayMedium!.copyWith(
        fontWeight: FontWeight.bold,
      );

  bool _isHover = false;

  /// To generate random color on hover.
  static final _random = Random();
  static const _colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
  ];

  @override
  Widget build(BuildContext context) {
    final color = _colors[_random.nextInt(_colors.length)];
    // Using random value at the end of heroTag to disable
    // Hero animation when navigating back to this screen.
    final heroTag = '${widget.char}-${_random.nextDouble()}';

    // To change textStyle on hover
    return AnimatedDefaultTextStyle(
      style: _isHover ? _textLarge.copyWith(color: color) : _textSmall,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // Pointer
        onEnter: (_) => setState(() => _isHover = true),
        onExit: (_) => setState(() => _isHover = false),
        child: GestureDetector(
          onTap: () => _onTap(color, heroTag),
          child: Hero(
            tag: heroTag,
            child: Text(widget.char),
          ),
        ),
      ),
    );
  }

  void _onTap(Color color, String tag) {
    if (widget.char == ' ') return;
    Navigator.of(context).push(
      SlidePageBuilder(
        pageBuilder: (context, animation, _) {
          return ProjectScreen(
            backgroundColor: color,
            heroTag: tag,
            animation: animation,
          );
        },
      ),
    );
  }
}
