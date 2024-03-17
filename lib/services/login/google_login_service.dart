import 'package:finding_your_movies_demo/enums/exception_type.dart';
import 'package:finding_your_movies_demo/models/user/user.dart';
import 'package:finding_your_movies_demo/resource/app_exceptions.dart';
import 'package:finding_your_movies_demo/services/login/login_service.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginService implements LoginService {
  @override
  Future<User> login() async {
    final googleSignIn = GoogleSignIn();
    // ignore: body_might_complete_normally_catch_error
    await googleSignIn.disconnect().catchError((error) {});

    final account = await googleSignIn.signIn();

    if (account == null) {
      throw AppException(ExceptionType.canceledByUser);
    }

    // Obtain the auth details from the request
    final googleAuth = await account.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    final authUser = userCredential.user;

    if (authUser == null) {
      throw AppException(ExceptionType.unauthorized, 'Can not find user');
    }

    return User(
        id: authUser.uid,
        email: authUser.email ?? '',
        avatarUrl: authUser.photoURL ?? '',
        phoneNumber: authUser.phoneNumber ?? '');
  }
}
