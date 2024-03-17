import 'package:finding_your_movies_demo/models/movie/movie.dart';
import 'package:finding_your_movies_demo/resource/base_bloc.dart';
import 'package:finding_your_movies_demo/resource/repositories/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailsBloC extends BaseBloC {
  final MovieRepository movieRepository;
  final Movie movie;

  MovieDetailsBloC({required this.movieRepository, required this.movie}) {
    _savedStateObject.add(movie.isSaved);
  }

  /// manage save button state
  final _savedStateObject = BehaviorSubject<bool>.seeded(false);
  Stream<bool> get savedStateStream => _savedStateObject.stream;

  void changeSaveState() {
    if (movie.isSaved) {
      movieRepository.unSaveMovie(movie.id);
    } else {
      movieRepository.saveMovie(movie.id);
    }
    movie.isSaved = !movie.isSaved;
    _savedStateObject.add(movie.isSaved);
  }

  @override
  void dispose() {
    _savedStateObject.close();
  }
}
