import 'package:flutter/material.dart';
import 'package:project_admin/screens/login/login_desktop.dart';
import 'package:project_admin/screens/login/login_mobile.dart';
import 'package:project_admin/screens/login/login_tablet.dart';
import 'package:project_admin/util/responsive.dart';

class Login extends StatefulWidget {
  TextEditingController _emailController = TextEditingController() ;
  TextEditingController _passwordController = TextEditingController() ;
  bool _isSaveFinger = false ;

  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return Responsive(
        desktop: LoginDesktop(
          emailController: widget._emailController,
          passwordController: widget._passwordController ,
          isSaveFinger: widget._isSaveFinger ,
          changeSaveFinger: () {
            setState(() {
              widget._isSaveFinger = !widget._isSaveFinger ;
            });
          },
        ),
        mobile: LoginMobile(
          emailController: widget._emailController,
          passwordController: widget._passwordController ,
          isSaveFinger: widget._isSaveFinger ,
          changeSaveFinger: () {
            setState(() {
              widget._isSaveFinger = !widget._isSaveFinger ;
            });
        },),
        tablet: LoginTablet(
          emailController: widget._emailController,
          passwordController: widget._passwordController ,
          isSaveFinger: widget._isSaveFinger,
          changeSaveFinger: () {
            setState(() {
              widget._isSaveFinger = !widget._isSaveFinger ;
            });
        },)
    );
  }
}
