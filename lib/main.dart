import 'package:flutter/material.dart';
import 'package:project_admin/my_app.dart';

import 'package:project_admin/theme/theme_provider.dart';
import 'package:provider/provider.dart';


void main() async {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider() ,
    child: MyApp(),
  ));
}
