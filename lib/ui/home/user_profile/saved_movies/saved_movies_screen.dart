import 'package:finding_your_movies_demo/l10n/translations.dart';
import 'package:flutter/material.dart';

class SavedMoviesScreen extends StatelessWidget {
  static const String routeName = 'saved-movies';

  const SavedMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).savedMovies),
      ),
    );
  }
}
