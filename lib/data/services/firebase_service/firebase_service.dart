import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_weather/data/services/shared_preferences_service/shared_preferences_service.dart';
import 'package:test_weather/domain/models/user_model/user_model.dart';

class FirebaseService {
  //Синглтон сервиса работы с FireBase
  static final FirebaseService _singleton = FirebaseService._internal();
  factory FirebaseService() => _singleton;
  FirebaseService._internal();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final SharedPreferencesService prefsService = SharedPreferencesServiceImpl();

  void onListenUser(void Function(User?)? doListen) async {
    auth.authStateChanges().listen(doListen);
  }

  Future<UserModel?> onRegister(
      {required String emailAddress, required String password}) async {
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: emailAddress.trim(),
        password: password.trim(),
      );
      await prefsService.savingLoginStatus(userCredential.user!.uid);

      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        return UserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          displayName: firebaseUser.displayName ?? '',
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  void onLogin({required String emailAddress, required String password}) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      await prefsService.savingLoginStatus(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void logOut() async {
    await prefsService.removeLoginStatus();
    await auth.signOut();
  }
}
