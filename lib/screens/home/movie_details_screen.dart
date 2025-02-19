// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:movies_app/models/movie_model.dart'; // For date formatting


// class MovieDetailsPage extends StatelessWidget {
//   final Movie movie;

//   // Constructor to pass the movie object to the page
//   const MovieDetailsPage({super.key, required this.movie});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(movie.title),
//         backgroundColor: Colors.deepPurple, // AppBar color
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Movie Poster and Title Section
//             Hero(
//               tag: 'movie-poster-${movie.id}',
//               child: Image.network(movie.posterPath),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 movie.title,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(height: 8),

//             // Movie Overview
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 movie.overview,
//                 style: TextStyle(fontSize: 16),
//                 textAlign: TextAlign.justify,
//               ),
//             ),
//             SizedBox(height: 16),

//             // Movie Release Date
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Release Date: ${DateFormat.yMMMd().format(DateTime.parse(movie.releaseDate))}',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//               ),
//             ),

//             // Movie Genres Section
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 children: [
//                   ...movie.genreIds.map((genreId) => Container(
//                     margin: EdgeInsets.only(right: 8),
//                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.deepPurple.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       'Genre $genreId', // Ideally, you'd fetch the genre name using the genreId.
//                       style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                     ),
//                   )),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),

//             // Actors Section (You can add your actors here if you have the data)
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 'Actors: ',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(height: 8),
//             SizedBox(
//               height: 100,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   // Example of an actor's circular image
//                   _actorImage('actor1.jpg'),
//                   _actorImage('actor2.jpg'),
//                   _actorImage('actor3.jpg'),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),

//             // Popularity Section
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 'Popularity: ${movie.popularity.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//               ),
//             ),
//             SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }

//   // Actor Image Widget (Circular)
//   Widget _actorImage(String imageName) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: CircleAvatar(
//         radius: 40,
//         backgroundImage: NetworkImage('https://example.com/$imageName'), // Replace with actor's image URL
//       ),
//     );
//   }
// }
