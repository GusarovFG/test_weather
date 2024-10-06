import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServise {
  //Синглтон сервиса работы с FireBase
  static final FirebaseServise _singleton = FirebaseServise._internal();
  factory FirebaseServise() => _singleton;
  FirebaseServise._internal();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? futternUser = FirebaseAuth.instance.currentUser;

  void onLoggin() {}

  void onRegister() {}

  void logOut() {}

  void onListenUser(void Function(User?)? doListen) {
    auth.authStateChanges().listen(doListen);
  }
}
