import 'package:flutter/material.dart';
import 'package:exchange_book/screens/dashboard/page/manager/home_admin.dart';
import 'package:exchange_book/screens/dashboard/page/client/profile.dart';
import 'package:exchange_book/screens/dashboard/widget/bottom_nav_bar.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Mydrawer(
          selection: widget.mainPage,
          handle: (item) {
            Navigator.pop(context) ;
            widget.hanlde(item) ;
          },
          status: widget.status
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavBar(
        selection: widget.mainPage,
        status: widget.status,
        handle: (item) {
          widget.hanlde(item) ;
        },
        openDraw: () {
          _scaffoldKey.currentState?.openDrawer() ;
        },
      ),
    );
  }
}
