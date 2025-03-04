import 'package:flutter/material.dart';

class WidgetButtonLogin extends StatefulWidget {
  Function () handle ;
  WidgetButtonLogin({super.key , required this.handle});

  @override
  State<WidgetButtonLogin> createState() => _WidgetButtonLoginState();
}

class _WidgetButtonLoginState extends State<WidgetButtonLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextButton(
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.blue),
            padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 15)),
            shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))
                )
            ),
          ),
          onPressed: () {widget.handle();},
          child: const Text(
            "Login",
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                letterSpacing: 1.5
            ),
          )
      ),
    );
  }
}
