import 'package:flutter/material.dart';

class WidgetBox extends StatefulWidget {
  Widget child ;
  int index ;
  WidgetBox({super.key , required this.child , required this.index});

  @override
  State<WidgetBox> createState() => _WidgetBoxState();
}

class _WidgetBoxState extends State<WidgetBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: widget.index + 1 == 1 ? Colors.green : Colors.greenAccent ,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12 ,
                offset: Offset(2, 2),
                blurRadius: 5
            ),
            BoxShadow(
                color: Colors.black12 ,
                offset: Offset(-2, -2),
                blurRadius: 5
            )
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
