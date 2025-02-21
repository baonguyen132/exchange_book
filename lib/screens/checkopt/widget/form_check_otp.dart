import 'package:flutter/material.dart';
import 'package:project_admin/screens/checkopt/widget/widget_number.dart';

class FormCheckOtp extends StatefulWidget {
  int number ;
  List<TextEditingController> listController ;
  List<FocusNode> listFocusCode ;

  bool isDesktop ;
  Function () sendOTPNew ;

  FormCheckOtp({super.key , required this.number , required this.listController , required this.listFocusCode , required this.sendOTPNew , this.isDesktop = false});

  @override
  State<FormCheckOtp> createState() => _FormCheckOtpState();
}

class _FormCheckOtpState extends State<FormCheckOtp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: const Text(
              "CONFIRM OTP",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20 ,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          const SizedBox(height: 30,),
          Container(
            child: Column(
              children: [
                Container(
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      WidgetNumber(textEditingController: widget.listController[0], focusNode: widget.listFocusCode[0], focusNodeNext: widget.listFocusCode[1], isDesktop: widget.isDesktop,),
                      WidgetNumber(textEditingController: widget.listController[1], focusNode: widget.listFocusCode[1], focusNodeNext: widget.listFocusCode[2], isDesktop: widget.isDesktop),
                      WidgetNumber(textEditingController: widget.listController[2], focusNode: widget.listFocusCode[2], focusNodeNext: widget.listFocusCode[3], isDesktop: widget.isDesktop),
                      WidgetNumber(textEditingController: widget.listController[3], focusNode: widget.listFocusCode[3], focusNodeNext: widget.listFocusCode[4], isDesktop: widget.isDesktop),
                      WidgetNumber(textEditingController: widget.listController[4], focusNode: widget.listFocusCode[4], focusNodeNext: widget.listFocusCode[5], isDesktop: widget.isDesktop),
                      WidgetNumber(textEditingController: widget.listController[5], focusNode: widget.listFocusCode[5], isDesktop: widget.isDesktop),
                    ],
                  ),
                ),
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: () {
                    String result = "" ;
                    for(int i = 0 ; i < widget.listController.length ; i++){
                      result += widget.listController[i].text;
                    }
                    if(result == widget.number.toString()){
                      Navigator.pop(context , true) ;
                    }
                    else {
                      Navigator.pop(context , false) ;
                    }
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      height: 50,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      child: const Text(
                        "Confirm",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: () {widget.sendOTPNew();},
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Column(
                      children: [
                        Text(
                          "Haven't received the code yet?",
                          textAlign: TextAlign.center,
                          style: TextStyle(

                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          "Send OTP",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
