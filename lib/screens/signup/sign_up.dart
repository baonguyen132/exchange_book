import 'package:exchange_book/screens/signup/cubit/sign_up_cubit.dart';
import 'package:exchange_book/screens/signup/widget/form_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/screens/signup/sign_up_desktop.dart';
import 'package:exchange_book/screens/signup/sign_up_mobile.dart';
import 'package:exchange_book/screens/signup/sign_up_tablet.dart';
import 'package:exchange_book/util/responsive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      lazy: true,
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          return Responsive(
            desktop: SignUpDesktop(
              backLogin: () => Navigator.pop(context),
              form:  FormSignUp(),
            ),
            mobile: SignUpMobile(
              backLogin: () => Navigator.pop(context),
              form:  FormSignUp(),
            ),
            tablet: SignUpTablet(
              backLogin: () => Navigator.pop(context),
              form:  FormSignUp(),
            ),
          );
        },
      ),
    );
  }
}
