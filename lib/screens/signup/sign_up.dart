import 'package:flutter/material.dart';
import 'package:exchange_book/screens/signup/sign_up_desktop.dart';
import 'package:exchange_book/screens/signup/sign_up_mobile.dart';
import 'package:exchange_book/screens/signup/sign_up_tablet.dart';
import 'package:exchange_book/util/responsive.dart';

class SignUp extends StatefulWidget {
  TextEditingController emailController = TextEditingController() ;
  TextEditingController fullnameController = TextEditingController() ;

  TextEditingController passwordController = TextEditingController() ;
  TextEditingController checkPasswordController = TextEditingController() ;

  TextEditingController dobController = TextEditingController() ;
  TextEditingController numberIdController = TextEditingController() ;

  TextEditingController addressController = TextEditingController() ;

  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
        desktop: SignUpDesktop(
            emailController: widget.emailController,
            fullnameController: widget.fullnameController,
            passwordController: widget.passwordController,
            checkPasswordController: widget.checkPasswordController,
            dobController: widget.dobController,
            numberIdController: widget.numberIdController,
            addressController: widget.addressController
        ),
        mobile: SignUpMobile(
            emailController: widget.emailController,
            fullnameController: widget.fullnameController,
            passwordController: widget.passwordController,
            checkPasswordController: widget.checkPasswordController,
            dobController: widget.dobController,
            numberIdController: widget.numberIdController,
            addressController: widget.addressController
        ),
        tablet: SignUpTablet(
            emailController: widget.emailController,
            fullnameController: widget.fullnameController,
            passwordController: widget.passwordController,
            checkPasswordController: widget.checkPasswordController,
            dobController: widget.dobController,
            numberIdController: widget.numberIdController,
            addressController: widget.addressController
        )
    );
  }
}
