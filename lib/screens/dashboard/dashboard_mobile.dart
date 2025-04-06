import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/home_admin.dart';
import 'package:project_admin/screens/dashboard/page/profile.dart';
import 'package:project_admin/screens/dashboard/widget/bottom_nav_bar.dart';

import '../../data/ConstraintData.dart';
import '../../model/MenuModal.dart';
import 'widget/MyDrawer.dart';

class DashboardMobile extends StatefulWidget {
  int status ;
  int mainPage ;
  Function (MenuModal item)  hanlde ;
  Widget child ;

  DashboardMobile({super.key , required this.status , required this.mainPage , required this.hanlde , required this.child});

  @override
  State<DashboardMobile> createState() => _DashboardMobileState();
}

class _DashboardMobileState extends State<DashboardMobile> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavBar(
        selection: widget.mainPage,
        status: widget.status,
        handle: (item) {
          widget.hanlde(item) ;
        },
      ),
    );
  }
}
