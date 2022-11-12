import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/project_model.dart';

class ProjectView extends StatefulWidget {
  const ProjectView({
    super.key,
    required this.project,
    required this.animation,
  });

  final Project project;
  final Animation<double> animation;

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  /// Screenshots PaveView controller.
  final _pageController = PageController();

  static const _detailsViewInterval =
      Interval(0.2, 0.7, curve: Curves.easeOutCubic);
  late final _detailsViewSlideAnimation = Tween<Offset>(
    begin: const Offset(0, 1),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: widget.animation,
    curve: _detailsViewInterval,
  ));
  late final _detailsViewFadeAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(CurvedAnimation(
    parent: widget.animation,
    curve: _detailsViewInterval,
  ));

  static const _screenshotsViewInterval =
      Interval(0.3, 1, curve: Curves.easeOutCubic);
  late final _screenshotsViewSlideAnimation = Tween<Offset>(
    begin: const Offset(1, 0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: widget.animation,
    curve: _screenshotsViewInterval,
  ));
  late final _screenshotsViewFadeAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(CurvedAnimation(
    parent: widget.animation,
    curve: _screenshotsViewInterval,
  ));

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
        );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SlideTransition(
            position: _detailsViewSlideAnimation,
            child: FadeTransition(
              opacity: _detailsViewFadeAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Text(
                      widget.project.title,
                      style: textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Description
                    Text(
                      widget.project.description,
                      style: textTheme.titleSmall,
                    ),
                    const SizedBox(height: 20),

                    // Features
                    Text(
                      'Features',
                      style: textTheme.headlineSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.project.features
                            .map(_featureToWidget)
                            .toList(),
                      ),
                    ),

                    // Repository url
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                      ),
                      onPressed: () async {
                        if (!await launchUrlString(widget.project.repoUrl)) {
                          log("Can't open repository url!");
                        }
                      },
                      child: const Text('Repository'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Screenshots PageView
        Expanded(
          child: SlideTransition(
            position: _screenshotsViewSlideAnimation,
            child: FadeTransition(
              opacity: _screenshotsViewFadeAnimation,
              child: Row(
                children: [
                  // Previous button
                  IconButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_back_ios),
                  ),

                  // Image
                  Expanded(
                    child: PageView.builder(
                      itemCount: widget.project.screenshots.length,
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        final url = widget.project.screenshots[index];
                        return Image.network(
                          url,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                // Shows a placeholder image while downloading large gif images.
                                // A .png version of each gif image was added to the assets directory.
                                if (url.endsWith('.gif'))
                                  Image.network('$url.png'),

                                CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  color: Colors.white54,
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),

                  // Next button
                  IconButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Convert a [Feature] to Widget.
  ///
  /// The [step] parameter is used to change the
  /// bullet point in each feature sub section.
  Widget _featureToWidget(Feature feat, [bool step = true]) {
    final title = _bulletPoint(feat.title, step);
    if (!feat.haveSubFeatures) return title;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Column(
            children:
                feat.features.map((f) => _featureToWidget(f, !step)).toList(),
          ),
        ),
      ],
    );
  }

  /// Add bullet point before text.
  ///
  /// The [step] parameter is used to change the
  /// bullet point in each feature sub section.
  Widget _bulletPoint(String title, bool step) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bullet point
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: step ? Colors.white : null,
              shape: BoxShape.circle,
              border: step ? null : Border.all(color: Colors.white, width: 1.5),
            ),
          ),
          const SizedBox(width: 10),

          // Title
          Flexible(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
