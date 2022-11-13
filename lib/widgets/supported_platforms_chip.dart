import 'package:flutter/material.dart';

import '../models/project_model.dart';

class SupportedPlatformsChip extends StatelessWidget {
  const SupportedPlatformsChip({
    super.key,
    required this.platforms,
  });

  final Set<Platforms> platforms;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: Chip(
        backgroundColor: Colors.transparent,
        side: const BorderSide(color: Colors.white54),
        label: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < platforms.length; i++) ...[
                Text(platforms.elementAt(i).name),
                if (i != platforms.length - 1) const Text(' | ')
              ]
            ],
          ),
        ),
      ),
    );
  }
}
