import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/models/genre.dart';
import 'package:movies_app/services/movie_service.dart';
import 'package:shimmer/shimmer.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MovieService _movieService = MovieService();
  late Future<List<Genre>> _genres;
  late Future<List<Movie>> _popularMovies;
  List<String> _carouselImages = [
    "https://image.tmdb.org/t/p/w500//q7HGGzF32Rfxlm0bChKMkU5mqtM.jpg",
    "https://image.tmdb.org/t/p/w500//7X7RGxxZXBrU2msm4AtL0v9g9pT.jpg",
    "https://image.tmdb.org/t/p/w500//5h9LwKp59c2dJEmN7p4ZyMxo0ch.jpg"
  ];

  @override
  void initState() {
    super.initState();
    _genres = _movieService.fetchGenres(); // Fetch genres
    _popularMovies = _movieService.fetchPopularMovies(); // Fetch popular movies
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'),
      ),
      body: ListView(
        children: [
          // Image Carousel
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CarouselSlider(
              items: _carouselImages.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: NetworkImage(url),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 250.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                enlargeCenterPage: true,
                viewportFraction: 1.0,
              ),
            ),
          ),

          // Genres List
          FutureBuilder<List<Genre>>(
            future: _genres,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No genres found.'));
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Genres',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Container(
                        height: 80.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final genre = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Chip(
                                label: Text(genre.name!),
                                backgroundColor: Colors.blueAccent,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),

          // Popular Movies List with Shimmer effect
          FutureBuilder<List<Movie>>(
            future: _popularMovies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 150.0,
                                height: 200.0,
                                color: Colors.white,
                              ),
                              SizedBox(height: 8.0),
                              Container(
                                width: 120.0,
                                height: 16.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No popular movies found.'));
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Popular Movies',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Container(
                        height: 250.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final movie = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150.0,
                                    height: 200.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    movie.title!,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:movies_app/models/movie_model.dart';
// import 'package:movies_app/models/genre.dart';
// import 'package:movies_app/services/movie_service.dart';
// import 'package:shimmer/shimmer.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Movie App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late Future<List<Genre>> _genres;
//   late Future<List<Movie>> _popularMovies;
//   late Future<List<String>> _carouselImages;
//   final MovieService _movieService = MovieService();

//   @override
//   void initState() {
//     super.initState();
//     _genres = fetchGenres(); // Fetch genres
//     _popularMovies = _movieService.fetchPopularMovies(); // Fetch popular movies
//     _carouselImages = fetchCarouselImages(); // Fetch carousel images dynamically
//   }

//   // Simulated method to fetch genres (update this method as needed)
//   Future<List<Genre>> fetchGenres() async {
//     return [
//       Genre(id: 1, name: 'Action'),
//       Genre(id: 2, name: 'Comedy'),
//       Genre(id: 3, name: 'Drama'),
//     ]; // Replace with actual genre fetch logic
//   }

//   // Fetching carousel images dynamically
//   Future<List<String>> fetchCarouselImages() async {
//     // For example, fetching images for the first three popular movies
//     List<Movie> popularMovies = await _movieService.fetchPopularMovies();
//     List<String> carouselImages = [];

//     // For the first three movies, fetch images
//     for (var i = 0; i < 3 && i < popularMovies.length; i++) {
//       List<String> movieImages = await _movieService.fetchMovieImages(popularMovies[i].id!);
//       carouselImages.add(movieImages.isNotEmpty ? movieImages[0] : ''); // Taking the first image for carousel
//     }
//     return carouselImages;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Movie App'),
//       ),
//       body: ListView(
//         children: [
//           // Image Carousel
//           FutureBuilder<List<String>>(
//             future: _carouselImages,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return Center(child: Text('No carousel images found.'));
//               } else {
//                 return Padding(
//                   padding: const EdgeInsets.only(top: 8.0),
//                   child: CarouselSlider(
//                     items: snapshot.data!.map((url) {
//                       return Builder(
//                         builder: (BuildContext context) {
//                           return Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.0),
//                               image: DecorationImage(
//                                 image: NetworkImage(url),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     }).toList(),
//                     options: CarouselOptions(
//                       height: 250.0,
//                       autoPlay: true,
//                       autoPlayInterval: Duration(seconds: 3),
//                       enlargeCenterPage: true,
//                       viewportFraction: 1.0,
//                     ),
//                   ),
//                 );
//               }
//             },
//           ),

//           // Genres List
//           FutureBuilder<List<Genre>>(
//             future: _genres,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return Center(child: Text('No genres found.'));
//               } else {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Genres',
//                         style: Theme.of(context).textTheme.titleLarge,
//                       ),
//                       Container(
//                         height: 80.0,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (context, index) {
//                             final genre = snapshot.data![index];
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Chip(
//                                 label: Text(genre.name!),
//                                 backgroundColor: Colors.blueAccent,
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//             },
//           ),

//           // Popular Movies List with Shimmer effect
//           FutureBuilder<List<Movie>>(
//             future: _popularMovies,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Shimmer.fromColors(
//                     baseColor: Colors.grey[300]!,
//                     highlightColor: Colors.grey[100]!,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: 5,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Column(
//                             children: [
//                               Container(
//                                 width: 150.0,
//                                 height: 200.0,
//                                 color: Colors.white,
//                               ),
//                               SizedBox(height: 8.0),
//                               Container(
//                                 width: 120.0,
//                                 height: 16.0,
//                                 color: Colors.white,
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 );
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return Center(child: Text('No popular movies found.'));
//               } else {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Popular Movies',
//                         style: Theme.of(context).textTheme.titleLarge,
//                       ),
//                       Container(
//                         height: 250.0,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (context, index) {
//                             final movie = snapshot.data![index];
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     width: 150.0,
//                                     height: 200.0,
//                                     decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                         image: NetworkImage('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
//                                         fit: BoxFit.cover,
//                                       ),
//                                       borderRadius: BorderRadius.circular(8.0),
//                                     ),
//                                   ),
//                                   SizedBox(height: 8.0),
//                                   Text(
//                                     movie.title!,
//                                     style: TextStyle(fontWeight: FontWeight.bold),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
