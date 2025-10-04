import 'package:flutter/material.dart';

class WidgetChooseGender extends StatefulWidget {
  final Function (String data) handle ;
  final String currentOption ;
  const WidgetChooseGender({super.key , required this.handle , required this.currentOption });



  @override
  State<WidgetChooseGender> createState() => _WidgetChooseGenderState();
}

class _WidgetChooseGenderState extends State<WidgetChooseGender> {
  final List<String> options = [
    "Male" ,
    "Female"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text(
          "Gender",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            Radio(
              value: options[0],
              groupValue: widget.currentOption,
              onChanged: (value) {widget.handle(value.toString());},
            ),
            Text(options[0])
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            Radio(
              value: options[1],
              groupValue: widget.currentOption,
              onChanged: (value) {widget.handle(value.toString());},
            ),
            Text(options[1])
          ],
        ),
      ],
    );
  }
}
