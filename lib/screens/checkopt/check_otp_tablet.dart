import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_admin/screens/checkopt/widget/form_check_otp.dart';

class CheckOtpTablet extends StatefulWidget {
  int number ;
  List<TextEditingController> listController ;
  List<FocusNode> listFocusCode ;
  Function () sendOTPNew ;

  CheckOtpTablet({super.key, required this.number, required this.listController , required this.listFocusCode , required this.sendOTPNew});

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
                padding: EdgeInsets.all(15),
                child: Container(
                  width: min(MediaQuery.of(context).size.width * 0.9, 450),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blue.shade500,
                            offset: Offset(0, 0),
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
