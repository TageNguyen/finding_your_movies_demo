import 'package:finding_your_movies_demo/models/movie/movie.dart';
import 'package:finding_your_movies_demo/services/api/movie/movie_api.dart';

class MovieApiImplement extends MovieApi {
  final String getListMoviesUrl =
      '/FEND16/movie-json-data/master/json/movies-coming-soon.json';

  @override
  Future<List<Movie>> getListMovies() async {
    final data = await getMethod(getListMoviesUrl);
    return (data['data'] as List?)?.map<Movie>((e) => Movie.fromJson(e)).toList() ?? [];
  }
}
