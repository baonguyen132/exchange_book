import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_admin/screens/login/widget/widget_form_login.dart';
class LoginTablet extends StatefulWidget {
  TextEditingController emailController  ;
  TextEditingController passwordController  ;
  bool isSaveFinger ;
  Function () changeSaveFinger ;

  LoginTablet({super.key, required this.emailController , required this.passwordController , required this.isSaveFinger , required this.changeSaveFinger});

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
              child: WidgetFormLogin(
                  emailController: widget.emailController,
                  passwordController: widget.passwordController,
                  isSaveFinger: widget.isSaveFinger,
                  changeSaveFinger: () {
                    widget.changeSaveFinger();
                  },
              )
            ),
          ),
        ),
      ),
    );
  }
}
