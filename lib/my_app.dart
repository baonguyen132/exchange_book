import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/dashboard.dart';
import 'package:project_admin/screens/login/login.dart';
import 'package:project_admin/screens/signup/sign_up.dart';
import 'package:project_admin/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        color: Theme.of(context).colorScheme.background ,
        child: Dashboard(),
      ),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        "/login": (context) => Login(),
        "/dashboard": (context) => Dashboard() ,
        "/signup": (context) => SignUp() ,
      },
    );
  }
}
