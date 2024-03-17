import 'package:finding_your_movies_demo/models/user/user.dart';
import 'package:finding_your_movies_demo/services/login/login_service.dart';

abstract class AuthenticationRepository {
  /// request login
  Future<void> logIn(LoginService loginService);

  /// get user informations
  Future<User?> getUserInformations();

  /// request logout
  Future<void> logOut();
}
