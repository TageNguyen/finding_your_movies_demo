import 'package:finding_your_movies_demo/models/user/user.dart';

abstract class LoginService {
  Future<User> login();
}
