import 'package:flutter/material.dart';
import 'package:exchange_book/screens/checkopt/widget/widget_number.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/check_otp_cubit.dart';

class FormCheckOtp extends StatefulWidget {
  final int number ;

  final bool isDesktop ;

  const FormCheckOtp({
    super.key ,
    required this.number ,
    this.isDesktop = false
  });

  @override
  State<FormCheckOtp> createState() => _FormCheckOtpState();
}

class _FormCheckOtpState extends State<FormCheckOtp> {
  late final List<TextEditingController> listController;
  late final List<FocusNode> listFocus;

  @override
  void initState() {
    super.initState();

    final list = context.read<CheckOtpCubit>().state.listDigital;
    listController = List.generate(6, (index) => TextEditingController(text: list[index],),
    );

    listFocus = List.generate(6, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in listController) {
      controller.dispose();
    }
    for (final focus in listFocus) {
      focus.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "CONFIRM OTP",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20 ,
                letterSpacing: 2,
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 30,),
          Column(
            children: [
              Wrap(
                spacing: 10, // nên thêm spacing cho dễ nhìn
                runSpacing: 10,
                alignment: WrapAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return WidgetNumber(
                    textEditingController: listController[index],
                    focusNode: listFocus[index],
                    focusNodeNext: index < 5 ? listFocus[index + 1] : null,
                    isDesktop: widget.isDesktop,

                    onChange: (value) {
                      context.read<CheckOtpCubit>().exchangeListDigital(value, index);
                    },
                  );
                }),
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: () {
                  String result = "" ;
                  for(int i = 0 ; i < listController.length ; i++){
                    result += listController[i].text;
                  }
                  if(result == widget.number.toString()) {
                    Navigator.pop(context , true) ;
                  } else {
                    Navigator.pop(context , false) ;
                  }
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
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
                onTap: () {context.read<CheckOtpCubit>().generateRandomNumber() ;},
                child: const MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Column(
                    children: [
                      Text("Haven't received the code yet?", textAlign: TextAlign.center,),
                      SizedBox(height: 10,),
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
          )
        ],
      ),
    );
  }
}
