import 'package:flutter/material.dart';
import 'package:exchange_book/screens/checkopt/widget/form_check_otp.dart';

class CheckOtpMobile extends StatefulWidget {
  final Widget formCheckOtp ;

  const CheckOtpMobile({
    super.key, required this.formCheckOtp ,
  });

  @override
  State<CheckOtpMobile> createState() => _CheckOtpMobileState();
}

class _CheckOtpMobileState extends State<CheckOtpMobile> {
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
                width: MediaQuery.of(context).size.width * 0.9,
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
                child: widget.formCheckOtp ,
              )
            ),
          )
      ),
    );
  }
}
