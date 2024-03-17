import 'package:finding_your_movies_demo/models/user/user.dart';
import 'package:finding_your_movies_demo/resource/repositories/authentication_repository.dart';
import 'package:finding_your_movies_demo/services/login/login_service.dart';
import 'package:finding_your_movies_demo/services/storage/app_shared_preferences.dart';

class AuthenticationRepositoryImplement implements AuthenticationRepository {
  AuthenticationRepositoryImplement();

  /// Request login
  @override
  Future<void> logIn(LoginService loginService) async {
    final userData = await loginService.login();
    await AppSharedPreferences.setLocalUserData(userData);
  }

  /// get logged in user's informations
  @override
  Future<User?> getUserInformations() async {
    return AppSharedPreferences.getLocalUserData();
  }

  @override
  Future<void> logOut() async {
    await AppSharedPreferences.setLocalUserData(null);
  }
}
