import 'dart:math';

import 'package:flutter/material.dart';
class LoginTablet extends StatefulWidget {
  final Widget formLogin ;
  const LoginTablet({super.key, required this.formLogin});

  @override
  State<LoginTablet> createState() => _LoginTabletState();
}

class _LoginTabletState extends State<LoginTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Container(
              width: min(550, MediaQuery.of(context).size.width * 0.9),
              padding: const EdgeInsets.symmetric(vertical: 30 ,  horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white.withAlpha(150),
                  borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
              child: widget.formLogin
            ),
          ),
        ),
      ),
    );
  }
}
