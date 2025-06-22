import 'package:flutter/material.dart';
class LoginMobile extends StatefulWidget {
  final Widget formLogin ;
  const LoginMobile({super.key, required this.formLogin});

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {



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
              width: MediaQuery.of(context).size.width * 0.9,
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
