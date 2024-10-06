import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesService {
  //Инициализация SharedPreferences
  Future<void> init();
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

  late final SharedPreferences _prefs;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> savingLoginStatus(String uid) async {
    await _prefs.setString('uid', uid);
  }

  @override
  Future<bool> userIsLoginCheck() async {
    return _prefs.containsKey('uid');
  }

  @override
  Future<void> removeLoginStatus() async {
    await _prefs.remove('uid');
  }
}
