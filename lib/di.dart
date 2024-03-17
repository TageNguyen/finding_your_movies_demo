import 'package:finding_your_movies_demo/providers/app_provider.dart';
import 'package:finding_your_movies_demo/providers/user_provider.dart';
import 'package:finding_your_movies_demo/repositories/authentication_repository_implement.dart';
import 'package:finding_your_movies_demo/resource/repositories/authentication_repository.dart';
import 'package:provider/provider.dart';

class DI {
  static List<InheritedProvider<dynamic>> getGlobalProviders() {
    List<InheritedProvider<dynamic>> independentServices = [
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
