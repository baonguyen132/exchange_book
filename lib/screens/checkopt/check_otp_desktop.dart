import 'package:flutter/material.dart';
import 'package:exchange_book/screens/checkopt/widget/form_check_otp.dart';

class CheckOtpDesktop extends StatefulWidget {
  int number ;
  List<TextEditingController> listController ;
  List<FocusNode> listFocusCode ;
  Function () sendOTPNew ;

  CheckOtpDesktop({super.key, required this.number, required this.listController , required this.listFocusCode , required this.sendOTPNew});

  @override
  State<CheckOtpDesktop> createState() => _CheckOtpDesktopState();
}

class _CheckOtpDesktopState extends State<CheckOtpDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          width: 800,
          height: 500,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  color: Colors.blue.withOpacity(0.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withAlpha(150),
                      offset: Offset(0, 0),
                      spreadRadius: 10,
                      blurRadius: 15
                    )
                  ]
                ),
              ),
              Expanded(
                  child: Center(
                    child: Container(
                      width: 400,
                      child: FormCheckOtp(
                        number: widget.number,
                        listController: widget.listController,
                        listFocusCode: widget.listFocusCode,
                        sendOTPNew: () {
                          widget.sendOTPNew() ;
                        },
                        isDesktop: true,
                      ),
                    ),
                  )
              ),
              Container(
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    color: Colors.blue.withOpacity(0.5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.indigo.withAlpha(150),
                          offset: Offset(0, 0),
                          spreadRadius: 10,
                          blurRadius: 15
                      )
                    ]
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
