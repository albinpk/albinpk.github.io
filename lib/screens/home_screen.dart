import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants.dart';
import '../data/projects.dart';
import '../widgets/single_character.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.onThemeModeChange,
  });

  /// Theme change callback.
  final ValueSetter<ThemeMode> onThemeModeChange;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  )..forward();

  /// Fade animation for "Hi, I am" Text.
  late final Animation<double> _hiTextFadeAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.1, 0.2, curve: Curves.ease),
    ),
  );

  /// Scale animation for "Hi, I am" Text.
  late final Animation<double> _hiTextScaleAnimation = Tween<double>(
    begin: 2,
    end: 1,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.35, 0.4, curve: Curves.ease),
    ),
  );

  /// Fade animation for NAME text.
  late final Animation<double> _nameTextFadeAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.35, 0.45, curve: Curves.ease),
    ),
  );

  /// Fade animation for the description text.
  late final Animation<double> _descriptionTextFadeAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.6, 0.65, curve: Curves.ease),
    ),
  );

  late final Animation<Offset> _themeButtonSlideAnimation = Tween<Offset>(
    begin: const Offset(0, -2),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.9, 1, curve: Curves.ease),
    ),
  );

  /// List of slide animations for contact cards.
  late final Iterable<Animation<Offset>> _contactCardSlideAnimations = const [
    Interval(0.900, 0.950, curve: Curves.ease),
    Interval(0.925, 0.975, curve: Curves.ease),
    Interval(0.950, 1.000, curve: Curves.ease),
  ].map((interval) => Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: _animationController, curve: interval),
      ));

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // TODO: Remove this
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "This webpage is under development.",
                  style: textTheme.bodyMedium!.copyWith(
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),

            // Theme button
            Positioned(
              top: 20,
              right: 20,
              child: SlideTransition(
                position: _themeButtonSlideAnimation,
                child: IconButton(
                  onPressed: () => widget.onThemeModeChange(
                    _isLightTheme ? ThemeMode.dark : ThemeMode.light,
                  ),
                  icon: _isLightTheme
                      ? const Icon(Icons.dark_mode)
                      : const Icon(Icons.light_mode),
                ),
              ),
            ),

            // "Hi, I am"
            Padding(
              padding: const EdgeInsets.only(bottom: 90),
              child: FadeTransition(
                opacity: _hiTextFadeAnimation,
                child: ScaleTransition(
                  scale: _hiTextScaleAnimation,
                  child: Text(
                    'Hi, I am',
                    style: textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // ALBIN PK
            FadeTransition(
              opacity: _nameTextFadeAnimation,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < kMyName.length; i++)
                    i < projects.length
                        ? SingleCharacter(i)
                        : Text(
                            kMyName[i],
                            style: textTheme.displaySmall!.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                ],
              ),
            ),

            // Description
            FadeTransition(
              opacity: _descriptionTextFadeAnimation,
              child: Padding(
                padding: const EdgeInsets.only(top: 90),
                child: Text(
                  'a passionate, self-taught Flutter developer.',
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Online profiles
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  // LinkedIn
                  _ContactCard(
                    value: '@albinpk',
                    color: Color(0xFF0F5996),
                    assetIcon: 'assets/icons/linkedin.svg',
                    url: 'https://www.linkedin.com/in/albinpk',
                  ),

                  // GitHub
                  _ContactCard(
                    value: '@albinpk',
                    color: Color(0xFF1B1A1A),
                    assetIcon: 'assets/icons/github.svg',
                    url: 'https://github.com/albinpk',
                  ),

                  // Email
                  _ContactCard(
                    value: 'abnpkdev@gmail.com',
                    color: Colors.red,
                    assetIcon: 'assets/icons/envelope-solid.svg',
                    url: 'mailto:abnpkdev@gmail.com',
                  ),
                ]
                    .asMap() // Wrap all cards with slide animation
                    .entries
                    .map((e) => Expanded(
                          child: SlideTransition(
                            position:
                                _contactCardSlideAnimations.elementAt(e.key),
                            child: e.value,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get _isLightTheme => Theme.of(context).brightness == Brightness.light;
}

class _ContactCard extends StatefulWidget {
  const _ContactCard({
    Key? key,
    required this.value,
    required this.url,
    required this.assetIcon,
    required this.color,
  }) : super(key: key);

  /// Username or user id.
  final String value;

  /// Profile url.
  final String url;

  /// Profile icon path.
  final String assetIcon;

  /// Background color. Only used in light mode
  final Color color;

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _isHover = false;

  late final String _clipBoardText =
      widget.url.startsWith('mailto:') ? widget.value : widget.url;

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 700;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return MouseRegion(
      onEnter: (event) => setState(() => _isHover = true),
      onExit: (event) => setState(() => _isHover = false),
      cursor: MaterialStateMouseCursor.clickable,
      child: GestureDetector(
        onTap: () async {
          if (!await launchUrlString(widget.url)) {
            log('Error launching url: ${widget.url}');
          }
        },
        child: AnimatedContainer(
          height: _isHover ? 80 : 40,
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
          alignment: Alignment.center,
          // This padding is used to centre the content of
          // the row without the icon button at the end.
          padding: isLargeScreen ? const EdgeInsets.only(left: 30) : null,
          decoration: BoxDecoration(
            color: isLightMode ? widget.color : const Color(0xFF2F3135),
            borderRadius: BorderRadius.vertical(
              top: _isHover ? const Radius.circular(10) : Radius.zero,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Profile icon; LinkedIn, GitHub, Email...
              SvgPicture.asset(
                widget.assetIcon,
                height: 20,
              ),

              if (isLargeScreen) ...[
                const SizedBox(width: 10),

                // Profile handle|username|id
                Flexible(
                  child: Text(
                    widget.value,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),

                // Copy to clipboard button
                AnimatedOpacity(
                  opacity: _isHover ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.copy),
                    color: Colors.white54,
                    iconSize: 18,
                    tooltip: 'Copy: $_clipBoardText',
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: _clipBoardText),
                      );
                    },
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
