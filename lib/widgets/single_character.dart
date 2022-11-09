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
        color: Colors.black,
      );

  /// TextStyle that change on mouse hover.
  late TextStyle _textStyle = _textSmall;

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      style: _textStyle,
      curve: Curves.ease,
      duration: const Duration(milliseconds: 200),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _textStyle = _textLarge),
        onExit: (_) => setState(() => _textStyle = _textSmall),
        child: Text(widget.char),
      ),
    );
  }
}
