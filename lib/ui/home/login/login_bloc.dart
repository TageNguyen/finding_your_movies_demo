import 'package:finding_your_movies_demo/resource/base_bloc.dart';
import 'package:finding_your_movies_demo/resource/repositories/authentication_repository.dart';
import 'package:finding_your_movies_demo/services/login/google_login_service.dart';

class LoginBloC extends BaseBloC {
  final AuthenticationRepository authenticationRepository;
  LoginBloC(this.authenticationRepository);

  /// request login with Google
  Future<void> loginWithGoogle() async {
    await authenticationRepository.logIn(GoogleLoginService());
  }

  @override
  void dispose() {}
}
