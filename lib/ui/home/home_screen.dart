import 'package:finding_your_movies_demo/l10n/translations.dart';
import 'package:finding_your_movies_demo/models/movie/movie.dart';
import 'package:finding_your_movies_demo/repositories/movie_repository_implement.dart';
import 'package:finding_your_movies_demo/resource/app_colors.dart';
import 'package:finding_your_movies_demo/resource/repositories/movie_repository.dart';
import 'package:finding_your_movies_demo/resource/widgets/error_message.dart';
import 'package:finding_your_movies_demo/resource/widgets/list_empty_message.dart';
import 'package:finding_your_movies_demo/resource/widgets/placeholder.dart';
import 'package:finding_your_movies_demo/services/api/movie/movie_api.dart';
import 'package:finding_your_movies_demo/services/api/movie/movie_api_implement.dart';
import 'package:finding_your_movies_demo/ui/home/home_bloc.dart';
import 'package:finding_your_movies_demo/ui/home/widgets/movie_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MovieApi>(
          create: (context) => MovieApiImplement(),
        ),
        ProxyProvider<MovieApi, MovieRepository>(
          update: (context, movieApi, previous) =>
              previous ?? MovieRepositoryImplement(movieApi: movieApi),
        ),
        ProxyProvider<MovieRepository, HomeBloC>(
          update: (context, movieRepository, previous) =>
              previous ?? HomeBloC(movieRepository: movieRepository),
        ),
      ],
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => __HomePageState();
}

class __HomePageState extends State<_HomePage> {
  late final HomeBloC homeBloC;

  @override
  void initState() {
    homeBloC = context.read<HomeBloC>();
    homeBloC.getMovieList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Movie>?>(
        stream: homeBloC.moviesStream,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const HomePagePlaceHolder();
          }

          if (snapshot.hasError) {
            return ErrorMessage(
              message: snapshot.error.toString(),
              onLoadmore: homeBloC.getMovieList,
            );
          }

          final moviesList = snapshot.data ?? [];

          if (moviesList.isEmpty) {
            return ListEmptyMessage(
              onLoadmore: homeBloC.getMovieList,
            );
          }

          return CustomScrollView(
            slivers: <Widget>[
              _buildMostPopularMoviePoster(context, moviesList[0]),
              _buildMoviesGridView(context, moviesList),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMostPopularMoviePoster(BuildContext context, Movie movie) {
    final viewDetailsButton = Material(
      color: AppColors.transparent,
      borderRadius: BorderRadius.circular(36.0),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(36.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36.0),
            border: Border.all(color: AppColors.white),
          ),
          child: Text(
            Translations.of(context).details,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ),
      ),
    );

    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.6,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                movie.posterurl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.black.withOpacity(0.7),
                      AppColors.black.withOpacity(0.4),
                      AppColors.transparent,
                    ],
                    stops: const [0.0, 0.4, 1.0],
                  ),
                ),
                child: viewDetailsButton,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoviesGridView(BuildContext context, List<Movie> moviesList) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 3 / 5,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => MovieItem(movie: moviesList[index]),
          childCount: moviesList.length,
        ),
      ),
    );
  }
}
