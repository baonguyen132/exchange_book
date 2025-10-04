import 'dart:math';

import 'package:exchange_book/screens/checkopt/cubit/check_otp_cubit.dart';
import 'package:exchange_book/screens/checkopt/widget/form_check_otp.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/screens/checkopt/check_otp_desktop.dart';
import 'package:exchange_book/screens/checkopt/check_otp_mobile.dart';
import 'package:exchange_book/screens/checkopt/check_otp_tablet.dart';
import 'package:exchange_book/util/responsive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CheckOtp extends StatefulWidget {
  final int number ;
  final String email ;
  const CheckOtp({super.key , required this.number , required this.email});

  @override
  State<CheckOtp> createState() => _CheckOtpState();
}

class _CheckOtpState extends State<CheckOtp> {



  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => CheckOtpCubit(widget.number, widget.email),
      lazy: true,
      child: BlocBuilder<CheckOtpCubit, CheckOtpState>(builder: (context, state) {
        return Responsive(
          desktop: CheckOtpDesktop(formCheckOtp: FormCheckOtp(number: context.read<CheckOtpCubit>().state.number, isDesktop: true,),),
          mobile: CheckOtpMobile(formCheckOtp: FormCheckOtp(number: context.read<CheckOtpCubit>().state.number,)),
          tablet: CheckOtpTablet(formCheckOtp: FormCheckOtp(number: context.read<CheckOtpCubit>().state.number,)),
        );
      },),
    );
  }


}
