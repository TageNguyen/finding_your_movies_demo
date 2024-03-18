import 'package:finding_your_movies_demo/models/movie/movie.dart';
import 'package:finding_your_movies_demo/resource/base_bloc.dart';
import 'package:finding_your_movies_demo/resource/repositories/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class SavedMoviesBloC extends BaseBloC {
  final MovieRepository movieRepository;

  SavedMoviesBloC({required this.movieRepository});

  /// manage list movies state
  final _savedMoviesObject = BehaviorSubject<List<Movie>>();
  Stream<List<Movie>?> get savedMoviesStream => _savedMoviesObject.stream;

  /// get saved movies
  Future<void> getSavedMovies() async {
    try {
      final data = await movieRepository.getSavedMovies();
      _savedMoviesObject.add(data);
    } catch (error) {
      _savedMoviesObject.addError(error);
      rethrow;
    }
  }

  @override
  void dispose() {
    _savedMoviesObject.close();
  }
}
