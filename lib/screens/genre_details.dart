// import 'package:flutter/material.dart';
// import 'package:movies_app/models/movie_model.dart';
// import 'package:movies_app/screens/home/movie_details_screen.dart';

// class GenreDetailsPage extends StatelessWidget {
//   final String genreName;  // Genre name for the page title
//   final List<Movie> movies; // List of movies under this genre

//   // Constructor to pass genre name and list of movies to the page
//   const GenreDetailsPage({super.key, required this.genreName, required this.movies});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(genreName), // Display the genre name in the app bar
//         backgroundColor: Colors.deepPurple, // AppBar color
//       ),
//       body: movies.isEmpty
//           ? Center(child: CircularProgressIndicator())  // Show a loader if no movies are available
//           : ListView.builder(
//               itemCount: movies.length,
//               itemBuilder: (context, index) {
//                 final movie = movies[index];
//                 return GestureDetector(
//                   onTap: () {
//                     // Navigate to Movie Details Page when a movie is clicked
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => MovieDetailsPage(movie: movie),
//                       ),
//                     );
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       elevation: 4,
//                       child: Row(
//                         children: [
//                           // Movie Poster
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.network(
//                               movie.backdropPath,
//                               height: 120,
//                               width: 80,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           // Movie Title and Rating
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   movie.title,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(height: 4),
//                                 Row(
//                                   children: [
//                                     Icon(Icons.star, color: Colors.yellow, size: 18),
//                                     SizedBox(width: 4),
//                                     Text(
//                                       movie.voteAverage.toString(),
//                                       style: TextStyle(fontSize: 14),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
