import 'package:flutter/material.dart';
import 'package:exchange_book/screens/dashboard/widget/MyDrawer.dart';
import 'package:exchange_book/screens/dashboard/widget/bottom_nav_bar.dart';
import '../../model/MenuModal.dart';
class DashboardTablet extends StatefulWidget {
  int status ;
  int mainPage ;
  Function (MenuModal item)  hanlde ;
  Widget child ;

  DashboardTablet({super.key , required this.status , required this.mainPage , required this.hanlde , required this.child});
  @override
  State<DashboardTablet> createState() => _DashboardTabletState();
}

class _DashboardTabletState extends State<DashboardTablet> {
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
