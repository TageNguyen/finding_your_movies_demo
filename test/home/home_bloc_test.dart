import 'package:finding_your_movies_demo/resource/repositories/movie_repository.dart';
import 'package:finding_your_movies_demo/ui/home/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finding_your_movies_demo/models/movie/movie.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'home_bloc_test.mocks.dart';

@GenerateMocks([MovieRepository])
void main() {
  late MovieRepository movieRepository;
  late HomeBloC homeBloC;

  setUp(() {
    movieRepository = MockMovieRepository();
    homeBloC = HomeBloC(movieRepository: movieRepository);
  });
  test('Test getMovieList success', () async {
    // Define the expected
    final List<Movie> movies = [
      Movie(id: '1', year: 2023, duration: const Duration(minutes: 90)),
      Movie(id: '2', year: 2024, duration: const Duration(minutes: 90)),
      Movie(id: '3', year: 2022, duration: const Duration(minutes: 90)),
    ];

    // Mock the behavior of fetchMovieList method
    when(movieRepository.getMovieList())
        .thenAnswer((realInvocation) => Future.value(movies));

    /// Call the method test
    homeBloC.getMovieList();

    /// Expect that the movieListStream has received the expected movies
    expect(await homeBloC.moviesStream.first, movies);
  });
}
