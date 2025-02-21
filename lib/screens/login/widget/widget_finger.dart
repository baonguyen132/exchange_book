import 'package:flutter/material.dart';

class WidgetFinger extends StatefulWidget {
  Function () handle ;
  WidgetFinger({super.key , required this.handle});

  @override
  State<WidgetFinger> createState() => _WidgetFingerState();
}

class _WidgetFingerState extends State<WidgetFinger> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {widget.handle();},
      child: const MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Icon(
          Icons.fingerprint,
          size: 45,
          color: Colors.blue,
        ),
      ),
    );
  }
}
