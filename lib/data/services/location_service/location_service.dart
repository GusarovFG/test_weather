import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationService {
  static final LocationService _singleton = LocationService._internal();
  factory LocationService() => _singleton;
  LocationService._internal();

  late Location _location;
  bool _serviceEnabled = false;
  PermissionStatus? _grantedPermission;

  void init() {
    _location = Location();
  }

  Future<bool> _checkPermission() async {
    if (await _checkService()) {
      _grantedPermission = await _location.hasPermission();
      if (_grantedPermission == PermissionStatus.denied) {
        _grantedPermission = await _location.requestPermission();
      }
    }
    return _grantedPermission == PermissionStatus.granted;
  }

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

  Future<LocationData?> getLocation() async {
    if (await _checkPermission()) {
      final locationData = await _location.getLocation();
      return locationData;
    } else {
      return null;
    }
  }
}
