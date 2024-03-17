import 'package:finding_your_movies_demo/models/movie/movie.dart';
import 'package:finding_your_movies_demo/resource/repositories/movie_repository.dart';
import 'package:finding_your_movies_demo/services/api/movie/movie_api.dart';

/// an implement class for [MovieRepository]
class MovieRepositoryImplement implements MovieRepository {
  final MovieApi movieApi;

  MovieRepositoryImplement({required this.movieApi});

  @override
  Future<List<Movie>> getMovieList() {
    return movieApi.getListMovies();
  }
}
