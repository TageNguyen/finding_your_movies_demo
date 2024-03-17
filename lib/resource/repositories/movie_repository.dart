import 'package:finding_your_movies_demo/models/movie/movie.dart';

abstract class MovieRepository {
  /// get movies list
  Future<List<Movie>> getMovieList();
}
