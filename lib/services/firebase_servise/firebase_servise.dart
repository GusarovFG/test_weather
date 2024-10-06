import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServise {
  //Синглтон сервиса работы с FireBase
  static final FirebaseServise _singleton = FirebaseServise._internal();
  factory FirebaseServise() => _singleton;
  FirebaseServise._internal();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? futternUser = FirebaseAuth.instance.currentUser;

  void onRegister(
      {required String emailAddress, required String password}) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
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
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void logOut() {}

  void onListenUser(void Function(User?)? doListen) {
    auth.authStateChanges().listen(doListen);
  }
}
