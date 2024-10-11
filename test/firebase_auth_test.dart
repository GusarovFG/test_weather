import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_weather/data/services/firebase_service/firebase_auth_service/firebase_service.dart';
import 'package:test_weather/domain/models/user_model/user_model.dart';

// Mock FirebaseAuth instance
class MockFirebaseAuth extends Mock implements FirebaseServiceImpl {}

void main() {
  group('AuthenticationService', () {
    late FirebaseServiceImpl authService;
    late MockFirebaseAuth mockFirebaseAuth;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      authService = FirebaseServiceImpl();
      authService.auth = mockFirebaseAuth.auth;
    });

    test('signUpUser returns a UserModel if signup successful', () async {
      when(authService.onRegister(
              emailAddress: '${RandomString().getRandomString(5)}@gmail.com',
              password: 'password'))
          .thenAnswer((_) async => FakeUserCredential());

      final result = await authService.onLogin(
          emailAddress: 'test@example.com', password: 'password');

      expect(result, isA<UserInfo>());
    });

    test('signUpUser returns null if signup fails', () async {
      when(mockFirebaseAuth.onRegister(emailAddress: '.', password: '.'))
          .thenThrow(FirebaseAuthException(code: 'error'));

      final result = await authService.onLogin(
          emailAddress: 'test@example.com', password: 'password');

      expect(result, null);
    });
  });
}

// Fake implementation of UserCredential for mocking
class FakeUserCredential extends Fake implements UserModel {}

// Fake implementation of User for mocking
class FakeUser extends Fake implements UserModel {
  @override
  String get email => 'fake@example.com';

  @override
  String? get displayName => 'Fake User';
}

class RandomString {
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
