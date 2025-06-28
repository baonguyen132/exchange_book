import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardTypeBookButton extends StatefulWidget {
  Function () handle ;
  Color color ;
  IconData iconData ;
  CardTypeBookButton({super.key , required this.handle , required this.color , required this.iconData});

  @override
  State<CardTypeBookButton> createState() => _CardTypeBookButtonState();
}

class _CardTypeBookButtonState extends State<CardTypeBookButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,

      decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: widget.color,
          ),
          borderRadius: BorderRadius.all(Radius.circular(100))
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          widget.handle() ;
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Icon(
            widget.iconData,
            color: widget.color,
          ),
        ),
      ),
    );
  }
}
