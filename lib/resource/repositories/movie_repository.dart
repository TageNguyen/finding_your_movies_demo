import 'package:finding_your_movies_demo/models/movie/movie.dart';

abstract class MovieRepository {
  /// get movies list
  Future<List<Movie>> getMovieList();

  /// get saved movies
  Future<List<Movie>> getSavedMovies();

  /// mark a movie has [movieId] as saved
  Future<void> saveMovie(String movieId);

  /// unmark a saved movie has [movieId]
  Future<void> unSaveMovie(String movieId);
}
