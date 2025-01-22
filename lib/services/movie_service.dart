import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';
import '../models/genre.dart';
import '../models/actor.dart';

class MovieService {
  static const String _apiKey = 'YOUR_API_KEY';
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchPopularMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Movie>.from(data['results'].map((movie) => Movie.fromJson(movie)));
    } else {
      throw Exception('Failed to fetch popular movies');
    }
  }

  Future<List<Genre>> fetchGenres() async {
    final response = await http.get(Uri.parse('$_baseUrl/genre/movie/list?api_key=$_apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Genre>.from(data['genres'].map((genre) => Genre.fromJson(genre)));
    } else {
      throw Exception('Failed to fetch genres');
    }
  }

  Future<List<Actor>> fetchPopularActors() async {
    final response = await http.get(Uri.parse('$_baseUrl/person/popular?api_key=$_apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Actor>.from(data['results'].map((actor) => Actor.fromJson(actor)));
    } else {
      throw Exception('Failed to fetch actors');
    }
  }

  static Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/search/movie?api_key=$_apiKey&query=$query'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Movie> movies = (data['results'] as List)
          .map((movieData) => Movie.fromJson(movieData))
          .toList();
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
