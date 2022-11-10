import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/project_model.dart';

class ProjectView extends StatefulWidget {
  const ProjectView({
    super.key,
    required this.project,
  });

  final Project project;

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  final _pageController = PageController();

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
                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        widget.project.features.map(_featureToWidget).toList(),
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

        // Screenshots PageView
        Expanded(
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
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      'assets/images/chat-room-dark.jpg',
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
