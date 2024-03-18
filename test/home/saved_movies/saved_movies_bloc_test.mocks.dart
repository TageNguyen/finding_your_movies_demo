// Mocks generated by Mockito 5.4.4 from annotations
// in finding_your_movies_demo/test/home/saved_movies/saved_movies_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:finding_your_movies_demo/models/movie/movie.dart' as _i4;
import 'package:finding_your_movies_demo/resource/repositories/movie_repository.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i2.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.Movie>> getMovieList() => (super.noSuchMethod(
        Invocation.method(
          #getMovieList,
          [],
        ),
        returnValue: _i3.Future<List<_i4.Movie>>.value(<_i4.Movie>[]),
      ) as _i3.Future<List<_i4.Movie>>);

  @override
  _i3.Future<List<_i4.Movie>> getSavedMovies() => (super.noSuchMethod(
        Invocation.method(
          #getSavedMovies,
          [],
        ),
        returnValue: _i3.Future<List<_i4.Movie>>.value(<_i4.Movie>[]),
      ) as _i3.Future<List<_i4.Movie>>);

  @override
  _i3.Future<void> saveMovie(String? movieId) => (super.noSuchMethod(
        Invocation.method(
          #saveMovie,
          [movieId],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> unSaveMovie(String? movieId) => (super.noSuchMethod(
        Invocation.method(
          #unSaveMovie,
          [movieId],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
