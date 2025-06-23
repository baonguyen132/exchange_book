import 'dart:math';

import 'package:flutter/material.dart';
import 'package:exchange_book/screens/checkopt/widget/form_check_otp.dart';

class CheckOtpTablet extends StatefulWidget {
  final int number ;
  final List<TextEditingController> listController ;
  final List<FocusNode> listFocusCode ;
  final Function () sendOTPNew ;

  const CheckOtpTablet({
    super.key,
    required this.number,
    required this.listController,
    required this.listFocusCode,
    required this.sendOTPNew
  });

  @override
  State<CheckOtpTablet> createState() => _CheckOtpTabletState();
}

class _CheckOtpTabletState extends State<CheckOtpTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: min(MediaQuery.of(context).size.width * 0.9, 450),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blue.shade500,
                            offset: const Offset(0, 0),
                            spreadRadius: 10 ,
                            blurRadius: 20
                        )
                      ]
                  ),
                  child: FormCheckOtp(
                    number: widget.number,
                    listController: widget.listController,
                    listFocusCode: widget.listFocusCode,
                    sendOTPNew: () {widget.sendOTPNew();},
                  ),
                )
            ),
          )
      ),
    );
  }
}
