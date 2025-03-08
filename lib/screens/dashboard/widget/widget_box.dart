import 'package:flutter/material.dart';

class WidgetBox extends StatefulWidget {
  Widget child ;
  bool condition ;
  Function () handle ;
  
  WidgetBox({super.key , required this.child , required this.condition , required this.handle});

  @override
  State<WidgetBox> createState() => _WidgetBoxState();
}

class _WidgetBoxState extends State<WidgetBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          widget.handle() ;
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            decoration: BoxDecoration(
              color: widget.condition  ? Colors.white.withOpacity(0.95) : Colors.grey.shade100,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow:  widget.condition  ? [
                const BoxShadow(
                    color: Colors.blue ,
                    offset: Offset(2, 2),
                    blurRadius: 2,
                    spreadRadius: 2
                ),
                const BoxShadow(
                    color: Colors.blue ,
                    offset: Offset(-2, -2),
                    blurRadius: 2,
                    spreadRadius: 2
                )
              ] : null,
              border: !widget.condition ? Border.all(
                color: Colors.blue.shade200,
                width: 2,
              ) : null ,
            ),
            child: widget.child,
          ),
        ),
      )
    );
  }
}
