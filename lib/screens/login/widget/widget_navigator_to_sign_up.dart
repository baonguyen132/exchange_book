import 'package:flutter/material.dart';

class WidgetNavigatorToSignUp extends StatefulWidget {
  const WidgetNavigatorToSignUp({super.key});

  @override
  State<WidgetNavigatorToSignUp> createState() =>
      _WidgetNavigatorToSignUpState();
}

class _WidgetNavigatorToSignUpState extends State<WidgetNavigatorToSignUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const Text(
            textAlign: TextAlign.center,
            "You do not have an account?",
            style: TextStyle(
              fontSize: 13,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/signup");
            },
            child: const MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(
                "Sign up",
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
