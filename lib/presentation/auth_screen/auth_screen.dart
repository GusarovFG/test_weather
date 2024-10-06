import 'package:flutter/material.dart';
import 'package:test_weather/data/services/firebase_service/firebase_service.dart';

// ignore: must_be_immutable
class AuthScreen extends StatefulWidget {
  bool isLogin;
  AuthScreen({super.key, required this.isLogin});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseService firebase = FirebaseService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void toggleIsLogin() {
    setState(() {
      widget.isLogin = !widget.isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 20,
                ),
                FilledButton(
                  onPressed: () {
                    widget.isLogin
                        ? firebase.onLogin(
                            emailAddress: _emailController.text,
                            password: _passwordController.text)
                        : firebase.onRegister(
                            emailAddress: _emailController.text,
                            password: _passwordController.text);
                  },
                  child: Text(widget.isLogin ? 'Вход' : 'Регистрация'),
                ),
                TextButton(
                  onPressed: () => toggleIsLogin(),
                  child: const Text('Войти'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
