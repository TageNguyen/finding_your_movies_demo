import 'translations.dart';

/// The translations for English (`en`).
class TranslationsEn extends Translations {
  TranslationsEn([super.locale = 'en']);

  @override
  String get ok => 'OK';

  @override
  String get pageNotFound => 'Page Not Found';

  @override
  String canNotFindAPageFor(String url) {
    return 'Can\'t find a page for: $url';
  }
}
