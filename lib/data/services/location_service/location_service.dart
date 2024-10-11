import 'package:flutter/services.dart';
import 'package:location/location.dart';

abstract class LocationService {
  //Инициализация сервиса для получения геолокации
  void init();
  //Проверка разрешений на использования геолокации устройства
  Future<bool> _checkPermission();
  //Проверка сервиса
  Future<bool> _checkService();
  //Получение данных о геолокации
  Future<LocationData?> getLocation();
}

class LocationServiceImpl extends LocationService {
  static final LocationServiceImpl _singleton = LocationServiceImpl._internal();
  factory LocationServiceImpl() => _singleton;
  LocationServiceImpl._internal();

  late Location _location;
  bool _serviceEnabled = false;
  PermissionStatus? _grantedPermission;

  @override
  void init() {
    _location = Location();
  }

  @override
  Future<bool> _checkPermission() async {
    if (await _checkService()) {
      _grantedPermission = await _location.hasPermission();
      if (_grantedPermission == PermissionStatus.denied) {
        _grantedPermission = await _location.requestPermission();
      }
    }
    return _grantedPermission == PermissionStatus.granted;
  }

  @override
  Future<bool> _checkService() async {
    try {
      _serviceEnabled = await _location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
      }
    } on PlatformException catch (e) {
      print(e.code);
      _serviceEnabled = false;
      await _checkService();
    }
    return _serviceEnabled;
  }

  @override
  Future<LocationData?> getLocation() async {
    if (await _checkPermission()) {
      final locationData = await _location.getLocation();
      return locationData;
    } else {
      return null;
    }
  }
}
