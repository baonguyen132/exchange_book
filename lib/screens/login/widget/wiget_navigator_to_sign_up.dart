import 'package:flutter/material.dart';

class WigetNavigatorToSignUp extends StatefulWidget {
  const WigetNavigatorToSignUp({super.key});

  @override
  State<WigetNavigatorToSignUp> createState() => _WigetNavigatorToSignUpState();
}

class _WigetNavigatorToSignUpState extends State<WigetNavigatorToSignUp> {
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
          const SizedBox(width: 10,),
          GestureDetector(
            onTap: () {Navigator.pushNamed(context, "/signup");},
            child: const MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(
                "Sign up",
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
