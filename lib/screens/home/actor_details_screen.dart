import 'package:movies_app/models/movie_model.dart';

class Actor {
  final int id;
  final String name;
  final String biography;
  final String profileImageUrl;
  final List<Movie> movies;

  Actor({
    required this.id,
    required this.name,
    required this.biography,
    required this.profileImageUrl,
    required this.movies,
  });

  factory Actor.fromJson(Map<String, dynamic> json) {
    List<Movie> movieList = [];
    if (json['movie_credits'] != null) {
      movieList = (json['movie_credits']['cast'] as List)
          .map((movieData) => Movie.fromJson(movieData))
          .toList();
    }

    return Actor(
      id: json['id'],
      name: json['name'],
      biography: json['biography'] ?? 'No biography available',
      profileImageUrl: 'https://image.tmdb.org/t/p/w500${json['profile_path']}',
      movies: movieList,
    );
  }
}
