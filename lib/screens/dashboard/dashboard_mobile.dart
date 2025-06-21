import 'package:exchange_book/screens/dashboard/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/screens/dashboard/widget/bottom_nav_bar.dart';

import '../../model/MenuModal.dart';
import 'widget/my_drawer.dart';

class DashboardMobile extends StatefulWidget {
  final Function (MenuModal item)  hanlde ;
  final Widget child ;
  final DashboardState state ;

  const DashboardMobile({
    super.key ,
    required this.hanlde ,
    required this.child,
    required this.state,
  });

  @override
  State<DashboardMobile> createState() => _DashboardMobileState();
}

class _DashboardMobileState extends State<DashboardMobile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(
        state: widget.state,
        handle: (item) {
          Navigator.pop(context) ;
          widget.hanlde(item) ;
        },
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavBar(
        state: widget.state,
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
