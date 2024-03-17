import 'package:finding_your_movies_demo/l10n/translations.dart';
import 'package:finding_your_movies_demo/models/movie/movie.dart';
import 'package:finding_your_movies_demo/resource/repositories/movie_repository.dart';
import 'package:finding_your_movies_demo/resource/widgets/error_message.dart';
import 'package:finding_your_movies_demo/resource/widgets/list_empty_message.dart';
import 'package:finding_your_movies_demo/resource/widgets/placeholder.dart';
import 'package:finding_your_movies_demo/resource/widgets/refresh_and_loadmore_widget.dart';
import 'package:finding_your_movies_demo/ui/home/user_profile/saved_movies/saved_movies_bloc.dart';
import 'package:finding_your_movies_demo/ui/home/widgets/movie_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedMoviesScreen extends StatelessWidget {
  static const String routeName = 'saved-movies';

  const SavedMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ProxyProvider<MovieRepository, SavedMoviesBloC>(
          update: (context, movieRepository, previous) =>
              previous ?? SavedMoviesBloC(movieRepository: movieRepository),
          dispose: (context, bloC) => bloC.dispose(),
        )
      ],
      child: const _SavedMoviesPage(),
    );
  }
}

class _SavedMoviesPage extends StatefulWidget {
  const _SavedMoviesPage();

  @override
  State<_SavedMoviesPage> createState() => _SavedMoviesPageState();
}

class _SavedMoviesPageState extends State<_SavedMoviesPage> {
  late final SavedMoviesBloC bloC;

  @override
  void initState() {
    bloC = context.read<SavedMoviesBloC>();
    bloC.getSavedMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).savedMovies),
      ),
      body: StreamBuilder<List<Movie>?>(
        stream: bloC.savedMoviesStream,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const GridViewPlaceHolder();
          }

          if (snapshot.hasError) {
            return ErrorMessage(
              message: snapshot.error.toString(),
              onRefresh: bloC.getSavedMovies,
            );
          }

          final moviesList = snapshot.data ?? [];

          if (moviesList.isEmpty) {
            return ListEmptyMessage(
              onRefresh: bloC.getSavedMovies,
            );
          }

          return RefreshAndLoadmoreWidget(
            onRefresh: bloC.getSavedMovies,
            child: GridView.builder(
              itemCount: moviesList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 3 / 5,
              ),
              itemBuilder: (BuildContext context, int index) =>
                  MovieItem(movie: moviesList[index]),
            ),
          );
        },
      ),
    );
  }
}
