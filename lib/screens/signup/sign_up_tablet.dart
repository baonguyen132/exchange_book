import 'dart:math';

import 'package:flutter/material.dart';
import 'package:exchange_book/screens/signup/widget/widget_form.dart';
import 'package:exchange_book/screens/signup/widget/widget_form_sign_up.dart';

class SignUpTablet extends StatefulWidget {
  TextEditingController emailController  ;
  TextEditingController fullnameController  ;

  TextEditingController passwordController  ;
  TextEditingController checkPasswordController  ;

  TextEditingController dobController  ;
  TextEditingController numberIdController  ;

  TextEditingController addressController  ;

  SignUpTablet({super.key , required this.emailController , required this.fullnameController , required this.passwordController , required this.checkPasswordController , required this.dobController , required this.numberIdController , required this.addressController});

  @override
  State<SignUpTablet> createState() => _SignUpTabletState();
}

class _SignUpTabletState extends State<SignUpTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Container(
                width: min(550, MediaQuery.of(context).size.width * 0.9),
                padding: const EdgeInsets.symmetric(vertical: 30 ,  horizontal: 20),
                margin: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(150),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: WidgetForm(
                    child: WidgetFormSignUp(
                        emailController: widget.emailController,
                        fullnameController: widget.fullnameController,
                        passwordController: widget.passwordController,
                        checkPasswordController: widget.checkPasswordController,
                        dobController: widget.dobController,
                        numberIdController: widget.numberIdController,
                        addressController: widget.addressController
                    )
                )
            ),
          ),
        ),
      ),
    );
  }
}
