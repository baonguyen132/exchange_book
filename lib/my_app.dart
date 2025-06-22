import 'package:exchange_book/screens/scan/scan_qr_code.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/screens/dashboard/dashboard.dart';
import 'package:exchange_book/screens/login/login.dart';
import 'package:exchange_book/screens/signup/sign_up.dart';
import 'package:exchange_book/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        color: Theme.of(context).colorScheme.background ,
        child: const Dashboard(),
      ),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        "/login": (context) => Login(),
        "/dashboard": (context) => const Dashboard() ,
        "/signup": (context) => SignUp() ,
        "/scanQR": (context)=> const ScanQrCode()
      },
    );
  }
}
