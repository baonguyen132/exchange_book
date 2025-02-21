import 'package:flutter/material.dart';

final List<String> options = [
  "Male" ,
  "Female"
];

class WigetChooseGender extends StatefulWidget {
  Function (String data) handle ;
  String currentOption ;
  WigetChooseGender({super.key , required this.handle , required this.currentOption });



  @override
  State<WigetChooseGender> createState() => _WigetChooseGenderState();
}

class _WigetChooseGenderState extends State<WigetChooseGender> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
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
                onChanged: (value) {
                  widget.handle(value.toString());
                },
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
                onChanged: (value) {
                  widget.handle(value.toString());
                },
              ),
              Text(options[1])
            ],
          ),
        ],
      ),
    );
  }
}
