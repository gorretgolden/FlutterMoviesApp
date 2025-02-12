import 'package:movies_app/models/movie_model.dart';

class Actor {
    bool adult;
    int gender;
    int id;
    String knownForDepartment;
    String name;
    String originalName;
    double popularity;
    String profilePath;
    List<Movie> movies;

    Actor({
        required this.adult,
        required this.gender,
        required this.id,
        required this.knownForDepartment,
        required this.name,
        required this.originalName,
        required this.popularity,
        required this.profilePath,
        required this.movies,
    });

}

