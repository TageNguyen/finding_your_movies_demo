import 'package:finding_your_movies_demo/models/movie/movie.dart';
import 'package:flutter/material.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const String routeName = 'movie-details';

  final Movie movie;
  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
    );
  }
}
