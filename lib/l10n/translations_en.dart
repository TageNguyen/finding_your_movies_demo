import 'translations.dart';

/// The translations for English (`en`).
class TranslationsEn extends Translations {
  TranslationsEn([String locale = 'en']) : super(locale);

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
}
