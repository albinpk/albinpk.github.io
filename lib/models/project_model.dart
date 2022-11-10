/// Project class.
///
/// Contains project [title], [description], [screenshots],
/// [repoUrl] and optional [liveDemoUrl].
class Project {
  const Project({
    required this.title,
    required this.description,
    required this.screenshots,
    required this.repoUrl,
    this.liveDemoUrl,
  });

  /// Project title.
  final String title;

  /// Project description.
  final String description;

  /// List of project screenshots.
  final List<String> screenshots;

  /// Project repository url.
  final String repoUrl;

  /// Project live demo url.
  final String? liveDemoUrl;
}
