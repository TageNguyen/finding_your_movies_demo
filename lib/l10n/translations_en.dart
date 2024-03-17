import 'translations.dart';

/// The translations for English (`en`).
class TranslationsEn extends Translations {
  TranslationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Finding your movies';

  @override
  String get ok => 'OK';

  @override
  String get pageNotFound => 'Page Not Found';

  @override
  String canNotFindAPageFor(String url) {
    return 'Can\'t find a page for: $url';
  }

  @override
  String get anErrorHasOccurredPleaseTryAgain => 'An error has occurred please try again';

  @override
  String get listIsEmpty => 'List is empty';

  @override
  String get details => 'Details';

  @override
  String get minutes => 'Minutes';

  @override
  String get releaseDate => 'Release date';

  @override
  String get rating => 'Rating';

  @override
  String get storyline => 'Storyline';

  @override
  String get genres => 'Genres';

  @override
  String get actors => 'Actors';

  @override
  String get duration => 'Duration';

  @override
  String get loginWithGoogle => 'Login with Google';

  @override
  String get letsFindYourBestMovie => 'Let\'s find your best movie';

  @override
  String get login => 'Login';

  @override
  String get loginFailed => 'Login failed';
}
