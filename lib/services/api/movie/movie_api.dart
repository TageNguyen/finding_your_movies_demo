import 'package:finding_your_movies_demo/models/movie/movie.dart';
import 'package:finding_your_movies_demo/services/api/base_api.dart';

abstract class MovieApi extends BaseApi {
  /// get list movies from server
  Future<List<Movie>> getListMovies();
}
