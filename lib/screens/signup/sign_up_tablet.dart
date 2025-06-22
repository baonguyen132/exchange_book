import 'dart:math';

import 'package:flutter/material.dart';
import 'package:exchange_book/screens/signup/widget/background_form.dart';
import 'package:exchange_book/screens/signup/widget/form_sign_up.dart';

import 'cubit/sign_up_cubit.dart';

class SignUpTablet extends StatefulWidget {

  final Widget form ;
  final Function () backLogin;

  const SignUpTablet({
    super.key,
    required this.backLogin,
    required this.form,
  });

  @override
  State<SignUpTablet> createState() => _SignUpTabletState();
}

class _SignUpTabletState extends State<SignUpTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: SafeArea(
          child: Center(
            child: Container(
                width: min(550, MediaQuery.of(context).size.width * 0.9),
                padding: const EdgeInsets.symmetric(vertical: 30 ,  horizontal: 20),
                margin: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(150),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: BackgroundForm(
                    handle: () { widget.backLogin(); },
                    child: widget.form
                )
            ),
          ),
        ),
      ),
    );
  }
}
