import 'package:flutter/material.dart';

class WidgetButtonSignUp extends StatefulWidget {
  Function () handle ;

  WidgetButtonSignUp({super.key , required this.handle});

  @override
  State<WidgetButtonSignUp> createState() => _WidgetButtonSignUpState();
}

class _WidgetButtonSignUpState extends State<WidgetButtonSignUp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.handle() ;
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          height: 55,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          child: const Text(
            "Sign up",
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                letterSpacing: 1.5
            ),
          ),
        ),
      ),
    );
  }
}
