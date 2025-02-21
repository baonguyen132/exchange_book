import 'package:flutter/material.dart';

class WidgetForm extends StatefulWidget {

  Widget child ;
  WidgetForm({super.key, required this.child});

  @override
  State<WidgetForm> createState() => _WidgetFormState();
}

class _WidgetFormState extends State<WidgetForm> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            child: GestureDetector(
              onTap: () {Navigator.pop(context) ;},
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(100))
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ),
        widget.child ,

      ],
    );
  }
}
