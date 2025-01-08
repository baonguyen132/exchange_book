import 'package:flutter/material.dart';
import 'package:project_admin/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'mainProject.dart';

void main() async {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider() ,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainProject(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
