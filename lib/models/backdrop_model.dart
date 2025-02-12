class Backdrop {
  final String filePath;
  final double aspectRatio;
  final int height;
  final int width;
  final double voteAverage;
  final int voteCount;
  final String? iso6391;

  Backdrop({
    required this.filePath,
    required this.aspectRatio,
    required this.height,
    required this.width,
    required this.voteAverage,
    required this.voteCount,
    this.iso6391,
  });

  // Factory method to create a Backdrop from a JSON object
  factory Backdrop.fromJson(Map<String, dynamic> json) {
    return Backdrop(
      filePath: json['file_path'],
      aspectRatio: json['aspect_ratio'].toDouble(),
      height: json['height'],
      width: json['width'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
      iso6391: json['iso_639_1'],
    );
  }

  // Method to convert Backdrop object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'file_path': filePath,
      'aspect_ratio': aspectRatio,
      'height': height,
      'width': width,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'iso_639_1': iso6391,
    };
  }
}
