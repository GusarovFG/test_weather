import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesService {
  //Сохранение статуса авторизации
  Future<void> savingLoginStatus(String uid);
  //Проверка на статус авторизации
  Future<bool> userIsLoginCheck();
  //Удаление статуса авторизации
  Future<void> removeLoginStatus();
}

// Синглтон для работы с SharedPreferences
class SharedPreferencesServiceImpl implements SharedPreferencesService {
  static final SharedPreferencesServiceImpl _singleton =
      SharedPreferencesServiceImpl._internal();
  factory SharedPreferencesServiceImpl() => _singleton;
  SharedPreferencesServiceImpl._internal();

  @override
  Future<void> savingLoginStatus(String uid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
  }

  @override
  Future<bool> userIsLoginCheck() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('uid');
  }

  @override
  Future<void> removeLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('uid');
  }
}
