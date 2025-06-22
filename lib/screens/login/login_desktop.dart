import 'dart:math';

import 'package:flutter/material.dart';
import 'package:exchange_book/screens/login/widget/form_login.dart';


class LoginDesktop extends StatefulWidget {
  final Widget formLogin ;
  const LoginDesktop({super.key, required this.formLogin });

  @override
  State<LoginDesktop> createState() => _LoginDesktopState();
}

class _LoginDesktopState extends State<LoginDesktop> {
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
                            ),
                          ),
                        )
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                            padding: const EdgeInsets.all(50),
                            child: widget.formLogin
                        ),
                      )
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
