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

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
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
      ),
    );
  }
}
