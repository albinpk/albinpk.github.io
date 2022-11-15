import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants.dart';
import '../data/projects.dart';
import '../widgets/single_character.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: Remove this
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "This webpage is under development.",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.redAccent,
              ),
        ),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 90),
              child: Text(
                'Hi, I am',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),

            // ALBIN PK
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < kMyName.length; i++)
                  i < projects.length
                      ? SingleCharacter(i)
                      : Text(
                          kMyName[i],
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(color: Colors.grey),
                        ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Text(
                'a passionate, self-taught Flutter developer.',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
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

  /// Background color.
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
    return Expanded(
      child: MouseRegion(
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
              color: widget.color,
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
                  color: Colors.white,
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
      ),
    );
  }
}
