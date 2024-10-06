import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_weather/data/services/shared_preferences_service/shared_preferences_service.dart';

class FirebaseService {
  //Синглтон сервиса работы с FireBase
  static final FirebaseService _singleton = FirebaseService._internal();
  factory FirebaseService() => _singleton;
  FirebaseService._internal();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final SharedPreferencesService prefsService = SharedPreferencesServiceImpl();

  void onListenUser(void Function(User?)? doListen) async {
    if (await prefsService.userIsLoginCheck()) {
      auth.authStateChanges().listen(doListen);
    }
  }

  void onRegister(
      {required String emailAddress, required String password}) async {
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await prefsService.savingLoginStatus(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
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
