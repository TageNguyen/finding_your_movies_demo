import 'package:finding_your_movies_demo/l10n/translations.dart';
import 'package:flutter/material.dart';

/// The not found screen
class NotFoundScreen extends StatelessWidget {
  static const String routeName = '/404';
  const NotFoundScreen({super.key, required this.uri});

  /// The uri that can not be found.
  final String uri;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Translations.of(context).pageNotFound)),
      body: Center(
        child: Text(Translations.of(context).canNotFindAPageFor(uri)),
      ),
    );
  }
}
