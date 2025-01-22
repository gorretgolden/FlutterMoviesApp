import 'package:flutter/material.dart';
import 'package:movies_app/models/downloaded_movie.dart';
import 'package:movies_app/services/download_service.dart';


class DownloadsScreen extends StatefulWidget {
  @override
  _DownloadsScreenState createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  late Future<List<DownloadedMovie>> _downloadedMovies;

  @override
  void initState() {
    super.initState();
    _downloadedMovies = DownloadService.getDownloadedMovies();  // Fetch downloaded movies
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Downloaded Movies'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<List<DownloadedMovie>>(
        future: _downloadedMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading downloaded movies.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No downloaded movies.'));
          } else {
            final downloadedMovies = snapshot.data!;

            return ListView.builder(
              itemCount: downloadedMovies.length,
              itemBuilder: (context, index) {
                final movie = downloadedMovies[index];

                return ListTile(
                  leading: movie.posterUrl.isNotEmpty
                      ? Image.network(movie.posterUrl, width: 50)
                      : Icon(Icons.movie),
                  title: Text(movie.title),
                  subtitle: Text('Offline'),
                  onTap: () {
                    // Navigate to movie playback screen (not implemented)
                    _viewMovie(movie);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  // Placeholder method for viewing the downloaded movie
  void _viewMovie(DownloadedMovie movie) {
    // You can use a video player package like `video_player` to play the downloaded movie
    // Navigate to a video player screen to play the movie from the file path (movie.filePath)
    print('Viewing movie: ${movie.title}');
  }
}
