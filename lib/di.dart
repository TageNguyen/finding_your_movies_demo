import 'package:finding_your_movies_demo/providers/app_provider.dart';
import 'package:finding_your_movies_demo/providers/user_provider.dart';
import 'package:finding_your_movies_demo/repositories/authentication_repository_implement.dart';
import 'package:finding_your_movies_demo/repositories/movie_repository_implement.dart';
import 'package:finding_your_movies_demo/resource/repositories/authentication_repository.dart';
import 'package:finding_your_movies_demo/resource/repositories/movie_repository.dart';
import 'package:finding_your_movies_demo/services/api/movie/movie_api.dart';
import 'package:finding_your_movies_demo/services/api/movie/movie_api_implement.dart';
import 'package:provider/provider.dart';

class DI {
  static List<InheritedProvider<dynamic>> getGlobalProviders() {
    List<InheritedProvider<dynamic>> independentServices = [
      Provider<MovieApi>(
        create: (context) => MovieApiImplement(),
      ),
      Provider<AuthenticationRepository>(
        create: (context) => AuthenticationRepositoryImplement(),
      ),
    ];

    List<InheritedProvider<dynamic>> dependentServices = [
      ProxyProvider<AuthenticationRepository, UserProvider>(
        update: (context, authenticationRepository, previous) =>
            previous ?? UserProvider(authenticationRepository),
        dispose: (_, bLoC) => bLoC.dispose(),
      ),
      ProxyProvider<MovieApi, MovieRepository>(
        update: (context, movieApi, previous) =>
            previous ?? MovieRepositoryImplement(movieApi: movieApi),
      ),
    ];

    List<InheritedProvider<dynamic>> uiConsumableProviders = [
      ChangeNotifierProvider<AppProvider>(
        create: (context) => AppProvider(),
        lazy: false,
      ),
    ];

    List<InheritedProvider<dynamic>> providers = [
      ...independentServices,
      ...dependentServices,
      ...uiConsumableProviders,
    ];
    return providers;
  }
}
