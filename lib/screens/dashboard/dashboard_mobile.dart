import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/home_admin.dart';
import 'package:project_admin/screens/dashboard/page/profile.dart';

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
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        drawer: Mydrawer(
          selection: widget.mainPage,
          status: widget.status,
          handle: (item) {
            Navigator.pop(context) ;
            widget.hanlde(item) ;
          },
        ),
        body: widget.child
    );
  }
}
