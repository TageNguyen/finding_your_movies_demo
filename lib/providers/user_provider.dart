import 'package:finding_your_movies_demo/models/user/user.dart';
import 'package:finding_your_movies_demo/resource/repositories/authentication_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserProvider {
  final AuthenticationRepository authenticationRepository;

  UserProvider(this.authenticationRepository);

  /// store user data
  static User? userData;

  /// current user data stream
  final _userObject = BehaviorSubject<User?>();
  Stream<User?> get currentUserStream => _userObject.stream;

  /// update user data stream with [user]
  void updateUserData(User? user) {
    _userObject.add(user);
    userData = user;
  }

  void logOut() async {
    authenticationRepository.logOut();
    _userObject.add(null);
    userData = User();
  }

  /// get user data
  Future<void> getUserInformations() async {
    final user = await authenticationRepository.getUserInformations();
    updateUserData(user);
  }

  /// dispose
  void dispose() {
    _userObject.close();
  }
}
