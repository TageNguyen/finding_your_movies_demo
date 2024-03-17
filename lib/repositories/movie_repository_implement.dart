import 'package:finding_your_movies_demo/enums/exception_type.dart';
import 'package:finding_your_movies_demo/models/movie/movie.dart';
import 'package:finding_your_movies_demo/providers/user_provider.dart';
import 'package:finding_your_movies_demo/resource/app_exceptions.dart';
import 'package:finding_your_movies_demo/resource/repositories/movie_repository.dart';
import 'package:finding_your_movies_demo/services/api/movie/movie_api.dart';
import 'package:finding_your_movies_demo/services/storage/app_shared_preferences.dart';

/// an implement class for [MovieRepository]
class MovieRepositoryImplement implements MovieRepository {
  final MovieApi movieApi;

  MovieRepositoryImplement({required this.movieApi});

  @override
  Future<List<Movie>> getMovieList() async {
    final movies = await movieApi.getListMovies();

    if (UserProvider.userData?.id != null) {
      final savedMovieIds =
          await AppSharedPreferences.getSavedMovieIds(UserProvider.userData!.id);
      for (final movie in movies) {
        movie.isSaved = savedMovieIds.contains(movie.id);
      }
    }

    return movies;
  }

  @override
  Future<List<Movie>> getSavedMovies() async {
    if (UserProvider.userData?.id == null) {
      throw AppException(ExceptionType.badRequest, 'Must login to get saved movies');
    }

    final movies = await movieApi.getListMovies();
    final savedMovieIds =
        await AppSharedPreferences.getSavedMovieIds(UserProvider.userData!.id);
    for (final movie in movies) {
      movie.isSaved = savedMovieIds.contains(movie.id);
    }

    return movies.where((movie) => movie.isSaved).toList();
  }

  @override
  Future<void> saveMovie(String movieId) async {
    if (UserProvider.userData?.id == null) {
      return;
    }

    final savedMovieIds =
        await AppSharedPreferences.getSavedMovieIds(UserProvider.userData!.id);

    if (!savedMovieIds.contains(movieId)) {
      savedMovieIds.add(movieId);
      AppSharedPreferences.setSavedMovieIds(UserProvider.userData!.id, savedMovieIds);
    }
  }

  @override
  Future<void> unSaveMovie(String movieId) async {
    if (UserProvider.userData?.id == null) {
      return;
    }

    final savedMovieIds =
        await AppSharedPreferences.getSavedMovieIds(UserProvider.userData!.id);

    if (savedMovieIds.contains(movieId)) {
      savedMovieIds.remove(movieId);
      AppSharedPreferences.setSavedMovieIds(UserProvider.userData!.id, savedMovieIds);
    }
  }
}
