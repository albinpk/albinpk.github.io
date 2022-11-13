import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../constants.dart';
import '../core/slide_page_builder.dart';
import '../data/projects.dart';
import '../screens/project_screen.dart';

class SingleCharacter extends StatefulWidget {
  const SingleCharacter(this.index, {super.key});

  final int index;

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

  late final String _char = kMyName[widget.index];

  /// Current color of the character.
  late Color _color;

  @override
  Widget build(BuildContext context) {
    final heroTag = _random.nextDouble();

    // To change textStyle on hover
    return AnimatedDefaultTextStyle(
      style: _isHover ? _textLarge.copyWith(color: _color) : _textSmall,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // Pointer
        onEnter: (_) {
          setState(() {
            _isHover = true;
            _color = _colors[_random.nextInt(_colors.length)];
          });
          _showOverlay();
        },
        onExit: (_) {
          _currentOverlay.remove();
          setState(() => _isHover = false);
        },
        child: GestureDetector(
          onTap: () => _onTap(heroTag),
          child: Hero(
            tag: heroTag,
            child: Text(_char),
          ),
        ),
      ),
    );
  }

  void _onTap(Object tag) {
    if (_char == ' ') return;
    Navigator.of(context).push(
      SlidePageBuilder(
        pageBuilder: (context, animation, _) {
          return ProjectScreen(
            projectIndex: widget.index,
            backgroundColor: _color,
            heroTag: tag,
            animation: animation,
          );
        },
      ),
    );
  }

  late final _overlayState = Overlay.of(context)!;
  late OverlayEntry _currentOverlay;

  /// Show overlay above the character.
  void _showOverlay() {
    // Find global position of the character
    final box = context.findRenderObject() as RenderBox;
    final position = box.localToGlobal(Offset.zero);

    _currentOverlay = OverlayEntry(
      // Place overlay above the character
      builder: (context) => Positioned(
        left: position.dx,
        bottom: position.dy + 10,
        child: _OverlayCard(
          projectIndex: widget.index,
          backgroundColor: _color,
        ),
      ),
    );
    _overlayState.insert(_currentOverlay);
  }
}

/// The widget appears as an overlay above the character.
class _OverlayCard extends StatefulWidget {
  const _OverlayCard({
    Key? key,
    required this.projectIndex,
    required this.backgroundColor,
  }) : super(key: key);

  final int projectIndex;

  /// Background color of the overlay card.
  final Color backgroundColor;

  @override
  State<_OverlayCard> createState() => _OverlayCardState();
}

class _OverlayCardState extends State<_OverlayCard>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );

  /// The overlay reveal animation.
  late final _clipWidthAnimation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.ease,
  );

  /// Timer to delay the animation.
  late final Timer _animationDelayTimer;

  @override
  void initState() {
    super.initState();
    // Show the overlay after 500 milliseconds
    _animationDelayTimer = Timer(
      const Duration(milliseconds: 500),
      _animationController.forward,
    );
  }

  @override
  void dispose() {
    _animationDelayTimer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedBuilder(
        animation: _clipWidthAnimation,
        builder: (context, child) {
          return Align(
            alignment: Alignment.centerLeft,
            widthFactor: _clipWidthAnimation.value,
            child: child,
          );
        },
        child: ColoredBox(
          color: widget.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              projects[widget.projectIndex].title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
