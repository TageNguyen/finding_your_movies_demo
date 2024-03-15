import 'package:finding_your_movies_demo/di.dart';
import 'package:finding_your_movies_demo/enums/app_language.dart';
import 'package:finding_your_movies_demo/l10n/translations.dart';
import 'package:finding_your_movies_demo/providers/app_provider.dart';
import 'package:finding_your_movies_demo/resource/app_theme.dart';
import 'package:finding_your_movies_demo/resource/widgets/loading_indicator.dart';
import 'package:finding_your_movies_demo/router/router_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: DI.getGlobalProviders(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, _) {
        return GestureDetector(
          onTap: () {
            /// hide current keyboard when user tap outside input fields
            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
          },
          child: MaterialApp.router(
            title: 'Finding Your Movies',
            debugShowCheckedModeBanner: false,
            // theme
            theme: AppTheme.darkTheme,
            // locales
            supportedLocales: Translations.supportedLocales,
            locale: appProvider.language?.toLocale(),
            localizationsDelegates: const [
              Translations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],

            /// router
            routerConfig: RouterConfiguration.router,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  child ?? const SizedBox.shrink(),
                  const LoadingIndicator(),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
