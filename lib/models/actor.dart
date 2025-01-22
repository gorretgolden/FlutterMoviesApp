class Actor {
  final String name;
  final String profilePath;

  Actor({required this.name, required this.profilePath});

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      name: json['name'],
      profilePath: json['profile_path'] ?? '',
    );
  }
}
