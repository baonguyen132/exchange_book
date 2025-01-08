import 'package:flutter/material.dart';
import 'package:project_admin/screens/desktop.dart';
import 'package:project_admin/screens/mobile.dart';
import 'package:project_admin/screens/tablet.dart';
import 'package:project_admin/util/responsive.dart';


class MainProject extends StatefulWidget {
  const MainProject({super.key});

  @override
  State<MainProject> createState() => _MainProjectState();
}

class _MainProjectState extends State<MainProject> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background ,
      child: Responsive(
          desktop: Desktop(),
          mobile: Mobile(),
          tablet: Tablet()
      ),
    );
  }
}
