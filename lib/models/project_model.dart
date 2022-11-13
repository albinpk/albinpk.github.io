/// Project class.
///
/// Contains project [title], [description], [features], [platforms],
/// [screenshots], [repoUrl] and optional [liveDemoUrl].
class Project {
  const Project({
    required this.title,
    required this.description,
    required this.features,
    required this.platforms,
    required this.screenshots,
    required this.repoUrl,
    this.liveDemoUrl,
  });

  /// Project title.
  final String title;

  /// Project description.
  final String description;

  /// List of project features.
  final List<Feature> features;

  /// Supported platforms.
  final Set<Platforms> platforms;

  /// List of project screenshots.
  final List<String> screenshots;

  /// Project repository url.
  final String repoUrl;

  /// Project live demo url.
  final String? liveDemoUrl;
}

/// Feature of a project.
/// May be contain sub features.
class Feature {
  const Feature(
    this.title, {
    this.features = const [],
  });

  /// Feature title.
  final String title;

  /// Sub features.
  final List<Feature> features;

  /// Whether this feature have sub features or not.
  bool get haveSubFeatures => features.isNotEmpty;
}

/// Enum of Platforms.
enum Platforms {
  mobile('Mobile'),
  desktop('Desktop'),
  web('Web');

  const Platforms(this.name);

  final String name;
}
