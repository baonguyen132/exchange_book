import 'dart:math';

import 'package:flutter/material.dart';
import 'package:exchange_book/screens/checkopt/check_otp_desktop.dart';
import 'package:exchange_book/screens/checkopt/check_otp_mobile.dart';
import 'package:exchange_book/screens/checkopt/check_otp_tablet.dart';
import 'package:exchange_book/util/responsive.dart';

import '../../model/UserModal.dart';

class CheckOtp extends StatefulWidget {
  int number ;
  String email ;
  CheckOtp({super.key , required this.number , required this.email});

  @override
  State<CheckOtp> createState() => _CheckOtpState();
}

class _CheckOtpState extends State<CheckOtp> {
  List<TextEditingController> listController = [
    TextEditingController()  ,
    TextEditingController()  ,
    TextEditingController()  ,
    TextEditingController()  ,
    TextEditingController()  ,
    TextEditingController()  ,
  ];
  List<FocusNode> listFocus = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for(int i = 0 ; i < listFocus.length ; i++) {
      listFocus[i].dispose() ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
        desktop: CheckOtpDesktop(
          number: widget.number,
          listController: listController,
          listFocusCode: listFocus,
          sendOTPNew: () {
            setState(() {
              widget.number = generateRandomNumber() ;
              UserModel.sendCodeOtp(widget.email, widget.number) ;
            });
          },
        ),
        mobile: CheckOtpMobile(
          number: widget.number,
          listController: listController,
          listFocusCode: listFocus,
          sendOTPNew: () {
            setState(() {
              widget.number = generateRandomNumber() ;
              UserModel.sendCodeOtp(widget.email, widget.number) ;
            });
          },
        ),
        tablet: CheckOtpTablet(
          number: widget.number,
          listController: listController,
          listFocusCode: listFocus,
          sendOTPNew: () {
            setState(() {
              widget.number = generateRandomNumber() ;
              UserModel.sendCodeOtp(widget.email, widget.number) ;
            });
          },
        ) ,
    );
  }

  int generateRandomNumber() {
    Random random = Random();
    // Tạo số ngẫu nhiên trong phạm vi từ 100000 đến 999999 (6 chữ số)
    return 100000 + random.nextInt(900000);
  }
}
