import 'package:flutter/material.dart';
import 'package:exchange_book/screens/signup/widget/background_form.dart';

class SignUpMobile extends StatefulWidget {

  final Widget form ;
  final Function () backLogin;

  const SignUpMobile({
    super.key ,
    required this.backLogin,
    required this.form,
  });

  @override
  State<SignUpMobile> createState() => _SignUpMobileState();
}

class _SignUpMobileState extends State<SignUpMobile> {

  
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
              width: MediaQuery.of(context).size.width * 0.9,
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
