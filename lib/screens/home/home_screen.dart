import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> movieImages = [];
  List<Map<String, dynamic>> genres = [];
  List<Map<String, dynamic>> popularMovies = [];
  List<Map<String, dynamic>> recommendedMovies = [];
  List<Map<String, dynamic>> latestMovies = [];
  List<Map<String, dynamic>> actors = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final moviesResponse = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=YOUR_API_KEY'));
      final genresResponse = await http.get(Uri.parse('https://api.themoviedb.org/3/genre/movie/list?api_key=YOUR_API_KEY'));
      final actorsResponse = await http.get(Uri.parse('https://api.themoviedb.org/3/person/popular?api_key=YOUR_API_KEY'));

      if (moviesResponse.statusCode == 200 && genresResponse.statusCode == 200 && actorsResponse.statusCode == 200) {
        final moviesData = json.decode(moviesResponse.body);
        final genresData = json.decode(genresResponse.body);
        final actorsData = json.decode(actorsResponse.body);

        setState(() {
          movieImages = List<String>.from(moviesData['results'].map((movie) => 'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}'));
          genres = List<Map<String, dynamic>>.from(genresData['genres']);
          popularMovies = List<Map<String, dynamic>>.from(moviesData['results']);
          recommendedMovies = popularMovies; // Replace with actual recommended movies logic
          latestMovies = popularMovies; // Replace with actual latest movies logic
          actors = List<Map<String, dynamic>>.from(actorsData['results']);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.purple,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Carousel
                  CarouselSlider(
                    items: movieImages.map((image) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      enlargeCenterPage: true,
                    ),
                  ),

                  SizedBox(height: 20),

                  // Genres Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Genres',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: genres.map((genre) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GenrePage(
                                  genreName: genre['name'],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.purple.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.purple),
                            ),
                            child: Text(
                              genre['name'],
                              style: TextStyle(color: Colors.purple),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Popular Movies Section
                  _buildMovieSection('Popular Movies', popularMovies),

                  // Recommended Movies Section
                  _buildMovieSection('Recommended Movies', recommendedMovies),

                  // Latest Movies Section
                  _buildMovieSection('Latest Movies', latestMovies),

                  // Actors Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Actors',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: actors.map((actor) {
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage('https://image.tmdb.org/t/p/w500${actor['profile_path']}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(actor['name']),
                          ],
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.download), label: 'Downloads'),
        ],
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildMovieSection(String title, List<Map<String, dynamic>> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: movies.map((movie) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage('https://image.tmdb.org/t/p/w500${movie['poster_path']}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(movie['title']),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class GenrePage extends StatelessWidget {
  final String genreName;

  const GenrePage({Key? key, required this.genreName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(genreName),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text(
          'Movies for $genreName will be displayed here.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
