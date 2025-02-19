// import 'package:flutter/material.dart';
// import 'package:movies_app/models/movie_model.dart';
// import 'package:movies_app/screens/home/movie_details_screen.dart';
// import 'package:movies_app/services/movie_service.dart';

// class SearchPage extends StatefulWidget {
//   const SearchPage({super.key});

//   @override
//   _SearchPageState createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   final TextEditingController _searchController = TextEditingController();
//   List<Movie> _searchResults = [];
//   bool _isLoading = false;

//   // Function to search for movies based on the query
//   void _searchMovies(String query) async {
//     if (query.isEmpty) {
//       setState(() {
//         _searchResults = [];
//       });
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       // Fetch movies from API service (assuming you have a method in API service)
//       final List<Movie> results = await MovieService.searchMovies(query);
//       setState(() {
//         _searchResults = results;
//       });
//     } catch (e) {
//       print('Error fetching movies: $e');
//       setState(() {
//         _searchResults = [];
//       });
//     }

//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search Movies'),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _searchController,
//               onChanged: (query) {
//                 _searchMovies(query);
//               },
//               decoration: InputDecoration(
//                 labelText: 'Search for movies...',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: _isLoading
//                 ? Center(child: CircularProgressIndicator())
//                 : _searchResults.isEmpty
//                     ? Center(child: Text('No movies found'))
//                     : ListView.builder(
//                         itemCount: _searchResults.length,
//                         itemBuilder: (context, index) {
//                           final movie = _searchResults[index];
//                           return GestureDetector(
//                             onTap: () {
//                               // Navigate to Movie Details Page when a movie is clicked
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => MovieDetailsPage(movie: movie),
//                                 ),
//                               );
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Card(
//                                 elevation: 4,
//                                 child: Row(
//                                   children: [
//                                     // Movie Poster
//                                     ClipRRect(
//                                       borderRadius: BorderRadius.circular(8),
//                                       child: Image.network(
//                                         movie.posterPath,
//                                         height: 120,
//                                         width: 80,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     SizedBox(width: 12),
//                                     // Movie Title and Rating
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             movie.title,
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           SizedBox(height: 4),
//                                           Row(
//                                             children: [
//                                               Icon(Icons.star, color: Colors.yellow, size: 18),
//                                               SizedBox(width: 4),
//                                               Text(
//                                                 movie.voteAverage.toString(),
//                                                 style: TextStyle(fontSize: 14),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//           ),
//         ],
//       ),
//     );
//   }
// }
