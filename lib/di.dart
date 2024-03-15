import 'package:finding_your_movies_demo/providers/app_provider.dart';
import 'package:provider/provider.dart';

class DI {
  static List<InheritedProvider<dynamic>> getGlobalProviders() {
    List<InheritedProvider<dynamic>> independentServices = [];

    List<InheritedProvider<dynamic>> dependentServices = [];

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
