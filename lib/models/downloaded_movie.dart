class DownloadedMovie {
  final String title;
  final String posterUrl;
  final String filePath;  // The local path where the movie is stored

  DownloadedMovie({
    required this.title,
    required this.posterUrl,
    required this.filePath,
  });
}
