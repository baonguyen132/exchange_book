import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/dashboard") ;
            }, 
          child: Text("click me" , style: TextStyle(color: Colors.white),),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.blue),
            padding: WidgetStatePropertyAll(EdgeInsets.all(20)),

          ),
        ),
      ),
    );
  }
}
