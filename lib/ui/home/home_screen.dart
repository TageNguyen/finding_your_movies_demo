import 'package:finding_your_movies_demo/l10n/translations.dart';
import 'package:finding_your_movies_demo/models/movie/movie.dart';
import 'package:finding_your_movies_demo/models/user/user.dart';
import 'package:finding_your_movies_demo/providers/user_provider.dart';
import 'package:finding_your_movies_demo/repositories/movie_repository_implement.dart';
import 'package:finding_your_movies_demo/resource/app_colors.dart';
import 'package:finding_your_movies_demo/resource/app_image_paths.dart';
import 'package:finding_your_movies_demo/resource/repositories/movie_repository.dart';
import 'package:finding_your_movies_demo/resource/widgets/app_fade_in_image.dart';
import 'package:finding_your_movies_demo/resource/widgets/error_message.dart';
import 'package:finding_your_movies_demo/resource/widgets/list_empty_message.dart';
import 'package:finding_your_movies_demo/resource/widgets/placeholder.dart';
import 'package:finding_your_movies_demo/services/api/movie/movie_api.dart';
import 'package:finding_your_movies_demo/services/api/movie/movie_api_implement.dart';
import 'package:finding_your_movies_demo/ui/home/home_bloc.dart';
import 'package:finding_your_movies_demo/ui/home/login/login_screen.dart';
import 'package:finding_your_movies_demo/ui/home/movie_details/movie_details_screen.dart';
import 'package:finding_your_movies_demo/ui/home/user_profile/user_profile_screen.dart';
import 'package:finding_your_movies_demo/ui/home/widgets/movie_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  late final UserProvider userProvider;

  @override
  void initState() {
    homeBloC = context.read<HomeBloC>();
    userProvider = context.read<UserProvider>();
    userProvider.getUserInformations();
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
    final userAvatar = Align(
      alignment: Alignment.topLeft,
      child: StreamBuilder<User?>(
        stream: userProvider.currentUserStream,
        builder: (_, snapshot) {
          final userData = snapshot.data;
          ImageProvider avatar = const AssetImage(AppImagePaths.profilePlaceholder);
          if (userData?.avatarUrl != null) {
            avatar = NetworkImage(userData!.avatarUrl);
          }

          return InkWell(
            onTap: () {
              if (userData != null) {
                context.goNamed(UserProfileScrenn.routeName);
              } else {
                context.goNamed(LoginScreen.routeName);
              }
            },
            borderRadius: BorderRadius.circular(100.0),
            child: Container(
              height: 36.0,
              width: 36.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.grey[350],
                border: Border.all(
                  color: AppColors.white,
                  width: 1.5,
                ),
                image: DecorationImage(
                  image: avatar,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );

    final viewDetailsButton = Material(
      color: AppColors.transparent,
      borderRadius: BorderRadius.circular(36.0),
      child: InkWell(
        onTap: () {
          context.goNamed(MovieDetailsScreen.routeName, extra: movie);
        },
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
              child: AppFadeInImage(imageUrl: movie.posterurl),
            ),
            Positioned.fill(
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.fromLTRB(12.0, 40.0, 12.0, 12.0),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    userAvatar,
                    viewDetailsButton,
                  ],
                ),
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
