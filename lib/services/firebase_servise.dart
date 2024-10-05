import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseServise {
  //Синглтон сервиса работы с FireBase
  FirebaseServise._iternal();
  static final FirebaseServise _instance = FirebaseServise._iternal();
  factory FirebaseServise.instance() => _instance;
}
