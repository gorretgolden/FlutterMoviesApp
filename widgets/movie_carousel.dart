import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MovieCarousel extends StatelessWidget {
  final List movies;

  const MovieCarousel(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 200, autoPlay: true),
      items: movies.map((movie) {
        return Builder(
          builder: (BuildContext context) {
            return Stack(
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Positioned(
                  bottom: 20,
                  left: 10,
                  child: Text(
                    movie['title'],
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            );
          },
        );
      }).toList(),
    );
  }
}
