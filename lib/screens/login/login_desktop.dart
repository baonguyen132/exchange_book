import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_admin/screens/login/widget/widget_button_login.dart';
import 'package:project_admin/screens/login/widget/widget_finger.dart';
import 'package:project_admin/screens/login/widget/widget_form_login.dart';
import 'package:project_admin/screens/login/widget/wiget_navigator_to_sign_up.dart';

import '../../util/widget_textfield_password_custome.dart';
import '../../util/wiget_textfield_custome.dart';

class LoginDesktop extends StatefulWidget {
  TextEditingController emailController  ;
  TextEditingController passwordController  ;
  bool isSaveFinger ;
  Function () changeSaveFinger ;

  LoginDesktop({super.key , required this.emailController , required this.passwordController , required this.isSaveFinger , required this.changeSaveFinger});

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
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          offset: Offset(0, 0),
                          spreadRadius: 10,
                          blurRadius: 20
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        offset: Offset(0, 0),
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
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 50),
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
                                    offset: Offset(0, 0),
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
                            padding: EdgeInsets.all(50),
                            child: WidgetFormLogin(
                              emailController: widget.emailController,
                              passwordController: widget.passwordController,
                              isSaveFinger: widget.isSaveFinger,
                              changeSaveFinger: () {
                                widget.changeSaveFinger();
                              },
                              isDesktop: true,
                            )
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
