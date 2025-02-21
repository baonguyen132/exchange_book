import 'package:flutter/material.dart';
import 'package:project_admin/screens/signup/widget/widget_form.dart';
import 'package:project_admin/screens/signup/widget/widget_form_sign_up.dart';



class SignUpMobile extends StatefulWidget {
  TextEditingController emailController  ;
  TextEditingController fullnameController  ;

  TextEditingController passwordController  ;
  TextEditingController checkPasswordController  ;

  TextEditingController dobController  ;
  TextEditingController numberIdController  ;

  TextEditingController addressController  ;

  SignUpMobile({super.key ,  required this.emailController , required this.fullnameController , required this.passwordController , required this.checkPasswordController , required this.dobController , required this.numberIdController , required this.addressController});

  @override
  State<SignUpMobile> createState() => _SignUpMobileState();
}

class _SignUpMobileState extends State<SignUpMobile> {

  
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
              width: MediaQuery.of(context).size.width * 0.9,
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
