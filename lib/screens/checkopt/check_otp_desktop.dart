import 'package:flutter/material.dart';

class CheckOtpDesktop extends StatefulWidget {
  final Widget formCheckOtp ;

  const CheckOtpDesktop({super.key, required this.formCheckOtp, });

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
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  color: Colors.blue.withOpacity(0.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withAlpha(150),
                      offset: const Offset(0, 0),
                      spreadRadius: 10,
                      blurRadius: 15
                    )
                  ]
                ),
              ),
              Expanded(child: Center(child: SizedBox(width: 400, child: widget.formCheckOtp,),)),
              Container(
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    color: Colors.blue.withOpacity(0.5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.indigo.withAlpha(150),
                          offset: const Offset(0, 0),
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
