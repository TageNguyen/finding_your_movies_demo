import 'package:finding_your_movies_demo/models/movie/movie.dart';
import 'package:finding_your_movies_demo/resource/base_bloc.dart';
import 'package:finding_your_movies_demo/resource/repositories/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloC extends BaseBloC {
  final MovieRepository movieRepository;

  HomeBloC({required this.movieRepository});

  /// manage list movies state
  final _moviesObject = BehaviorSubject<List<Movie>>();
  Stream<List<Movie>?> get moviesStream => _moviesObject.stream;

  /// get movies list
  Future<void> getMovieList() async {
    try {
      final data = await movieRepository.getMovieList();
      _moviesObject.add(data);
    } catch (error) {
      _moviesObject.addError(error);
      rethrow;
    }
  }

  @override
  void dispose() {
    _moviesObject.close();
  }
}
