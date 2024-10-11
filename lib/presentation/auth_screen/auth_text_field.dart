import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthTextField extends StatefulWidget {
  final String title;
  bool isSecure = false;
  bool _isHidenText = false;

  final TextEditingController _emailController;

  AuthTextField({
    super.key,
    required TextEditingController emailController,
    required this.title,
    required this.isSecure,
  })  : _emailController = emailController,
        _isHidenText = isSecure;

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
