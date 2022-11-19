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

class _SingleCharacterState extends State<SingleCharacter>
    with SingleTickerProviderStateMixin {
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
  Color _color = Colors.blue;

  /// A Map for storing the [_OverlayController] of opened overlays.
  ///
  /// On the mouse-leave event, reverse the [_OverlayController.animationController]
  /// instead of removing the overlay.
  static final Map<int, _OverlayController> _overlayControllers = {};

  @override
  Widget build(BuildContext context) {
    final heroTag = _random.nextDouble();
    final textTheme = Theme.of(context).textTheme;

    // To change textStyle on hover
    return AnimatedDefaultTextStyle(
      style: _isHover
          ? textTheme.displayMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: _color,
            )
          : textTheme.displaySmall!,
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
          _overlayControllers[widget.index]!.animationController.reverse();
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

  @override
  void dispose() {
    _overlayState.dispose();
    for (final c in _overlayControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  /// Show overlay above the character.
  void _showOverlay() {
    final box = context.findRenderObject() as RenderBox;
    final position = box.localToGlobal(Offset.zero);
    // If the character overlay exists, then update its
    // position and color, and forward its animation.
    if (_overlayControllers.containsKey(widget.index)) {
      final overlayController = _overlayControllers[widget.index]!;
      overlayController.positionNotifier.value = position;
      overlayController.colorNotifier.value = _color;
      overlayController.animationController.forward();
      return;
    }

    // If the character overlay does not exist, then create the overlay.
    // Create an animation controller for the overlay and add it to the Map.
    final positionNotifier = ValueNotifier<Offset>(position);
    final colorNotifier = ValueNotifier<Color>(_color);
    final controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
      reverseDuration: const Duration(milliseconds: 300),
    );
    _overlayControllers[widget.index] = _OverlayController(
      animationController: controller,
      positionNotifier: positionNotifier,
      colorNotifier: colorNotifier,
    );

    _overlayState.insert(
      OverlayEntry(
        // The positionListener is at the top because the position
        // of the overlay does not change frequently, but the
        // color does when every mouse enter event occurs.
        builder: (context) => ValueListenableBuilder<Offset>(
          valueListenable: positionNotifier,
          builder: (context, offset, child) {
            return Positioned(
              left: offset.dx,
              bottom: offset.dy + 70,
              child: child!,
            );
          },
          child: ValueListenableBuilder<Color>(
            valueListenable: colorNotifier,
            builder: (context, color, _) {
              return _OverlayCard(
                projectIndex: widget.index,
                backgroundColor: color,
                animationController: controller,
              );
            },
          ),
        ),
      ),
    );
    controller.forward(); // Start the reveal animation
  }
}

/// The widget appears as an overlay above the character.
class _OverlayCard extends StatelessWidget {
  _OverlayCard({
    Key? key,
    required this.projectIndex,
    required this.backgroundColor,
    required this.animationController,
  }) : super(key: key);

  final int projectIndex;

  /// Background color of the overlay card.
  final Color backgroundColor;

  /// Overlay reveal animation controller.
  final AnimationController animationController;

  /// The overlay reveal animation.
  /// Using an interval curve to delay the animation start
  late final _clipWidthAnimation = CurvedAnimation(
    parent: animationController,
    curve: const Interval(0.4, 1, curve: Curves.ease),
  );

  /// Overlay fade animation.
  late final CurvedAnimation _fadeAnimation = CurvedAnimation(
    parent: animationController,
    curve: const Interval(0.4, 0.8, curve: Curves.ease),
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ClipRect(
      child: FadeTransition(
        opacity: _fadeAnimation,
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
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Project',
                    style: textTheme.bodyMedium!.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    projects[projectIndex].title,
                    style: textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Controller for an overlay.
///
/// Contains [animationController], [positionNotifier] and [colorNotifier].
class _OverlayController {
  const _OverlayController({
    required this.animationController,
    required this.positionNotifier,
    required this.colorNotifier,
  });

  /// Overlay animation controller.
  final AnimationController animationController;

  /// Overlay position notifier.
  ///
  /// This will help update the position of existing
  /// overlays after the browser window resizes.
  final ValueNotifier<Offset> positionNotifier;

  /// Overlay color notifier.
  ///
  /// This will help update the color of
  /// existing overlays on every mouse-enter event.
  final ValueNotifier<Color> colorNotifier;

  /// Dispose [animationController], [positionNotifier] and [colorNotifier].
  void dispose() {
    animationController.dispose();
    positionNotifier.dispose();
    colorNotifier.dispose();
  }
}
