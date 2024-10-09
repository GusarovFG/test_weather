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
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  widget.isLogin ? 'Войти' : 'Регистрация',
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  height: 50,
                ),
                AuthTextField(
                  emailController: _emailController,
                  title: 'Введите email',
                  isSecure: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                AuthTextField(
                  emailController: _passwordController,
                  title: 'Введите пароль',
                  isSecure: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 60,
                  width: MediaQuery.sizeOf(context).width - 40,
                  child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blue),
                    ),
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.isLogin
                        ? 'У Вас нет аккаунта?'
                        : 'У Вас уже есть аккаунт?'),
                    TextButton(
                      onPressed: () => toggleIsLogin(),
                      child: Text(widget.isLogin ? 'Регистрация' : 'Войти'),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AuthTextField extends StatefulWidget {
  final String title;
  bool isSecure = false;
  bool _isHidenText = false;
  AuthTextField({
    super.key,
    required TextEditingController emailController,
    required this.title,
    required this.isSecure,
  })  : _emailController = emailController,
        _isHidenText = isSecure;

  final TextEditingController _emailController;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      TextField(
        obscureText: widget._isHidenText,
        enableSuggestions: widget.isSecure ? false : true,
        autocorrect: false,
        decoration: InputDecoration(
          label: Text(
            widget.title,
            style: const TextStyle(color: Colors.blue),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 1,
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
        controller: widget._emailController,
      ),
      widget.isSecure
          ? Positioned(
              right: 10,
              top: 10,
              bottom: 10,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    widget._isHidenText = !widget._isHidenText;
                  });
                },
                icon: const Icon(
                  Icons.remove_red_eye_sharp,
                  color: Colors.blue,
                ),
              ),
            )
          : const SizedBox()
    ]);
  }
}
