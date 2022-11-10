/// Project class.
///
/// Contains project [title], [description], [features],
/// [screenshots], [repoUrl] and optional [liveDemoUrl].
class Project {
  const Project({
    required this.title,
    required this.description,
    required this.features,
    required this.screenshots,
    required this.repoUrl,
    this.liveDemoUrl,
  });

  /// Project title.
  final String title;

  /// Project description.
  final String description;

  final List<Feature> features;

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
