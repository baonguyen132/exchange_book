import 'package:exchange_book/screens/login/cubit/login_cubit.dart';
import 'package:exchange_book/screens/login/widget/form_login.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/screens/login/login_desktop.dart';
import 'package:exchange_book/screens/login/login_mobile.dart';
import 'package:exchange_book/screens/login/login_tablet.dart';
import 'package:exchange_book/util/responsive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => LoginCubit(),
      lazy: true,
      child: BlocBuilder<LoginCubit , LoginState>(builder: (context, state) {
        return Responsive(
            desktop: LoginDesktop(formLogin: FormLogin(isDesktop: true,),),
            mobile:  LoginMobile(formLogin: FormLogin(),),
            tablet:  LoginTablet(formLogin: FormLogin(),)
        );
      },),
    );
  }
}
