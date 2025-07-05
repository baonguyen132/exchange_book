import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

class WidgetButtonCustom extends StatefulWidget {
  final Function () handle ;
  final String text ;
  const WidgetButtonCustom({super.key , required this.handle , required this.text});

  @override
  State<WidgetButtonCustom> createState() => _WidgetButtonCustomState();
}

class _WidgetButtonCustomState extends State<WidgetButtonCustom> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.handle() ;
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius:const  BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: const Offset(0, 1),
                )
              ]
          ),
          height: 53,
          alignment: Alignment.center,
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style:  const TextStyle(
              fontSize: 18,
              color: Colors.white,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w100
            ),
          ),
        ),
      ),
    );
  }
}
