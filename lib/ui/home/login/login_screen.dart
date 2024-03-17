import 'package:finding_your_movies_demo/l10n/translations.dart';
import 'package:finding_your_movies_demo/providers/app_provider.dart';
import 'package:finding_your_movies_demo/providers/user_provider.dart';
import 'package:finding_your_movies_demo/resource/app_exceptions.dart';
import 'package:finding_your_movies_demo/resource/app_icon_paths.dart';
import 'package:finding_your_movies_demo/resource/helpers/message_helpers.dart';
import 'package:finding_your_movies_demo/resource/repositories/authentication_repository.dart';
import 'package:finding_your_movies_demo/ui/home/home_screen.dart';
import 'package:finding_your_movies_demo/ui/home/login/login_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProxyProvider<AuthenticationRepository, LoginBloC>(
      update: (context, authenticationRepository, previous) =>
          previous ?? LoginBloC(authenticationRepository),
      dispose: (context, bloC) => bloC.dispose(),
      child: const _LoginPage(),
    );
  }
}

class _LoginPage extends StatefulWidget {
  const _LoginPage();

  @override
  State<_LoginPage> createState() => __LoginPageState();
}

class __LoginPageState extends State<_LoginPage> {
  late final LoginBloC bloC;
  late final UserProvider userProvider;
  late final AppProvider appProvider;

  @override
  void initState() {
    bloC = context.read<LoginBloC>();
    userProvider = context.read<UserProvider>();
    appProvider = context.read<AppProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).login),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 160.0, 16.0, 16.0),
          child: Column(
            children: <Widget>[
              Text(
                Translations.of(context).appName,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontFamily: 'Bad Script'),
              ),
              const SizedBox(height: 20.0),
              Text(
                Translations.of(context).letsFindYourBestMovie,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontFamily: 'dancing script'),
              ),
              const SizedBox(height: 40.0),
              _buildLogInWithGoogleButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogInWithGoogleButton(BuildContext context) {
    return ElevatedButton(
      onPressed: loginWithGoogle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppIconPaths.googleIcon,
            height: 24.0,
            width: 24.0,
          ),
          const SizedBox(width: 8.0),
          Text(
            Translations.of(context).loginWithGoogle,
          ),
        ],
      ),
    );
  }

  Future<void> loginWithGoogle() async {
    try {
      appProvider.showLoading();
      await bloC.loginWithGoogle();
      await userProvider.getUserInformations();
      // ignore: use_build_context_synchronously
      context.goNamed(HomeScreen.routeName);
    } on AppException catch (error) {
      MessageHelper.showToastMessage(error.message, isErrorMessage: true);
      rethrow;
    } catch (error) {
      // ignore: use_build_context_synchronously
      MessageHelper.showToastMessage(Translations.of(context).loginFailed,
          isErrorMessage: true);
      print('error: $error');
      rethrow;
    } finally {
      // ignore: use_build_context_synchronously
      context.read<AppProvider>().hideLoading();
    }
  }
}
