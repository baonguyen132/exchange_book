import 'dart:math';

import 'package:flutter/material.dart';
import 'package:exchange_book/screens/signup/widget/background_form.dart';

class SignUpDesktop extends StatefulWidget {

  final Function () backLogin ;
  final Widget form ;
  const SignUpDesktop({
    super.key,
    required this.backLogin, required this.form,
  });

  @override
  State<SignUpDesktop> createState() => _SignUpDesktopState();
}

class _SignUpDesktopState extends State<SignUpDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.blue,
                  Colors.blueAccent
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
          ),
          child: Center(
            child: Container(
              width: min(1000, MediaQuery.of(context).size.width * 0.9),
              height: min(600, MediaQuery.of(context).size.height * 0.8),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        offset: const Offset(0, 0),
                        spreadRadius: 10,
                        blurRadius: 20
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      offset: const Offset(0, 0),
                      spreadRadius: -15,
                      blurRadius: 25,
                    ),
                  ]
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          decoration: const BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      color: Colors.blue,
                                      width: 5 ,
                                      style: BorderStyle.solid
                                  )
                              )
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.blue.withOpacity(0.5),
                                      offset: const Offset(0, 0),
                                      blurRadius: 10 ,
                                      spreadRadius: 55
                                  )
                                ]
                            ),
                            child: BackgroundForm(handle:() => widget.backLogin(),),
                          ),
                        ),
                      )
                  ),
                  Expanded(child: SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(50), child: widget.form,),)
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
