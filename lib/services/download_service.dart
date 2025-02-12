import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movies_app/models/downloaded_movie.dart';
import 'package:path_provider/path_provider.dart';

class DownloadService {
  // Method to download a movie and save it to local storage
  static Future<String> downloadMovie(String movieUrl, String title) async {
    final cacheManager = DefaultCacheManager();

    // Download the movie file (this will give you a FileInfo object)
    final fileInfo = await cacheManager.downloadFile(movieUrl, key: title);

    // Get the directory to store the downloaded movie
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$title.mp4';  // Modify extension as needed

    // Create a new file from the downloaded FileInfo object
    final file = File(filePath);

    // Save the downloaded file to the new location
    await file.writeAsBytes(await fileInfo.file.readAsBytes());

    return filePath;  // Return the file path where the movie is saved
    }

  // Method to fetch the list of downloaded movies from local storage
  static Future<List<DownloadedMovie>> getDownloadedMovies() async {
    final directory = await getApplicationDocumentsDirectory();
    final directoryPath = directory.path;

    // You can save movie data in a JSON file or simply save the file names in a list.
    final files = Directory(directoryPath).listSync();

    List<DownloadedMovie> downloadedMovies = [];

    // Check if file is a movie (you can add more file checks here)
    for (var file in files) {
      if (file is File && file.path.endsWith('.mp4')) {
        // Here, movie data like title and poster can be extracted or saved separately
        downloadedMovies.add(DownloadedMovie(
          title: file.uri.pathSegments.last,
          posterUrl: '',  // You can store the poster URL as well
          filePath: file.path,
        ));
      }
    }

    return downloadedMovies;
  }
}
