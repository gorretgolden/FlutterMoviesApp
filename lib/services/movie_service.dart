import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/utils/constants.dart';
import '../models/movie_model.dart';
import '../models/genre.dart';
import '../models/actor.dart';

void main() async{
 try {
    List<Genre> genres = await fetchGenres();
    for (var genre in genres) {
      print("${genre.name}");
    }
  } catch (e) {
    print("Error fetching genres: $e");
  }
}

// class MovieService {
Future<List<Movie>> fetchPopularMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&language=en-US&page=1'),
      headers: {
        "accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Movie>.from(data['results'].map((movie) => Movie.fromJson(movie)));
    } else {
      print("Error: ${response.statusCode} - ${response.body}");
      throw Exception('Failed to fetch popular movies');
    }
  }


 // Fetch movie images from the API
  Future<List<String>> fetchMovieImages(int movieId) async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/$movieId/images?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<String> imageUrls = [];
      
      for (var image in data['posters']) {
        imageUrls.add('https://image.tmdb.org/t/p/w500${image['file_path']}');
      }
      return imageUrls;
    } else {
      throw Exception('Failed to load movie images');
    }
  }
  Future<List<Genre>> fetchGenres() async {
    final response = await http.get(Uri.parse('$baseUrl/genre/movie/list?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Genre>.from(data['genres'].map((genre) => Genre.fromJson(genre)));
    } else {
      throw Exception('Failed to fetch genres');
    }
  }

//   Future<List<Actor>> fetchPopularActors() async {
//     final response = await http.get(Uri.parse('$_baseUrl/person/popular?api_key=$_apiKey'));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return List<Actor>.from(data['results'].map((actor) => Actor.fromJson(actor)));
//     } else {
//       throw Exception('Failed to fetch actors');
//     }
//   }

//   static Future<List<Movie>> searchMovies(String query) async {
//     final response = await http.get(
//       Uri.parse('$_baseUrl/search/movie?api_key=$_apiKey&query=$query'),
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       List<Movie> movies = (data['results'] as List)
//           .map((movieData) => Movie.fromJson(movieData))
//           .toList();
//       return movies;
//     } else {
//       throw Exception('Failed to load movies');
//     }
//   }
// 
// }
