import 'package:flutter/material.dart';
import 'package:exchange_book/screens/checkopt/widget/form_check_otp.dart';

class CheckOtpMobile extends StatefulWidget {
  int number ;
  List<TextEditingController> listController ;
  List<FocusNode> listFocusCode ;
  Function () sendOTPNew ;

  CheckOtpMobile({super.key , required this.number, required this.listController , required this.listFocusCode , required this.sendOTPNew});

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
              padding: EdgeInsets.all(15),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
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
                  sendOTPNew: () {widget.sendOTPNew() ;},
                ),
              )
            ),
          )
      ),
    );
  }
}
