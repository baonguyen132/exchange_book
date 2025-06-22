import 'package:flutter/material.dart';
import 'package:exchange_book/my_app.dart';

import 'package:exchange_book/theme/theme_provider.dart';
import 'package:provider/provider.dart';


void main() async {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider() ,
    child: MyApp(),
  ));
}
