import 'package:finding_your_movies_demo/l10n/translations.dart';
import 'package:finding_your_movies_demo/models/movie/movie.dart';
import 'package:finding_your_movies_demo/providers/user_provider.dart';
import 'package:finding_your_movies_demo/resource/app_colors.dart';
import 'package:finding_your_movies_demo/resource/extensions/double_ex.dart';
import 'package:finding_your_movies_demo/resource/repositories/movie_repository.dart';
import 'package:finding_your_movies_demo/resource/widgets/app_fade_in_image.dart';
import 'package:finding_your_movies_demo/resource/widgets/star_rating_row.dart';
import 'package:finding_your_movies_demo/ui/home/movie_details/movie_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = 'movie-details';
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ProxyProvider<MovieRepository, MovieDetailsBloC>(
          update: (context, movieRepository, previous) =>
              previous ??
              MovieDetailsBloC(movieRepository: movieRepository, movie: movie),
          dispose: (context, bloC) => bloC.dispose(),
        )
      ],
      child: const _MovieDetailsPage(),
    );
  }
}

class _MovieDetailsPage extends StatefulWidget {
  const _MovieDetailsPage();

  @override
  State<_MovieDetailsPage> createState() => __MovieDetailsPageState();
}

class __MovieDetailsPageState extends State<_MovieDetailsPage> {
  late final MovieDetailsBloC bloC;
  late final Movie movie;

  @override
  void initState() {
    bloC = context.read<MovieDetailsBloC>();
    movie = bloC.movie;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _buildMoviePoster(context),
          _buildMovieDetails(),
        ],
      ),
    );
  }

  Widget _buildMoviePoster(BuildContext context) {
    Widget buildButton(IconData iconData, void Function()? onTap) {
      return Material(
        color: AppColors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(100),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(100),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconData,
              size: 20.0,
              color: AppColors.white,
            ),
          ),
        ),
      );
    }

    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.3,
      automaticallyImplyLeading: false,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: AppFadeInImage(imageUrl: movie.posterurl),
            ),
            Positioned.fill(
              child: Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(8.0),
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 36.0, 16.0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // back button
                      buildButton(
                        Icons.arrow_back_ios_rounded,
                        () => context.pop(),
                      ),
                      // save movie button
                      if (UserProvider.userData != null)
                        StreamBuilder<bool>(
                          stream: bloC.savedStateStream,
                          builder: (context, snapshot) {
                            bool isSaved = snapshot.data ?? false;
                            return buildButton(
                              isSaved
                                  ? Icons.bookmark_rounded
                                  : Icons.bookmark_border_rounded,
                              bloC.changeSaveState,
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieDetails() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // movie title
            Text(
              movie.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8.0),

            // release date
            Text(
              '${Translations.of(context).releaseDate}: ${movie.releaseDate}',
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 8.0),

            // duration
            Text(
              '${Translations.of(context).duration}: ${movie.duration.inMinutes} ${Translations.of(context).minutes}',
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey),
            ),
            const SizedBox(height: 8.0),

            // rating
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    movie.imdbRating.toStringFormat(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 14.0, height: 0.6),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StarRatingRow(rating: movie.imdbRating),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0, left: 4.0),
                        child: Text(
                          '${movie.ratings.length} ${Translations.of(context).rating}',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: AppColors.grey[100],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // storyline
            Text(
              '${Translations.of(context).storyline}:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              movie.storyline,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16.0),

            // Genres
            Text(
              '${Translations.of(context).genres}:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              movie.genres.join(', '),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16.0),

            // Actors
            Text(
              '${Translations.of(context).actors}:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              movie.actors.join(', '),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
