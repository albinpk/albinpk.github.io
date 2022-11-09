import 'dart:math';

import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      style: _isHover
          ? _textLarge.copyWith(
              color: Colors.primaries[_random.nextInt(Colors.primaries.length)],
            )
          : _textSmall,
      curve: Curves.ease,
      duration: const Duration(milliseconds: 200),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHover = true),
        onExit: (_) => setState(() => _isHover = false),
        child: Text(widget.char),
      ),
    );
  }
}
