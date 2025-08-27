import 'package:exchange_book/screens/dashboard/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/screens/dashboard/widget/my_drawer.dart';
import 'package:exchange_book/screens/dashboard/widget/bottom_nav_bar.dart';
import '../../model/menu_modal.dart';
class DashboardTablet extends StatefulWidget {

  final DashboardState state ;
  final Function (MenuModal item)  hanlde ;
  final Widget child ;

  
  const DashboardTablet({
    super.key ,
    required this.hanlde , 
    required this.child, required this.state,
  });
  @override
  State<DashboardTablet> createState() => _DashboardTabletState();
}

class _DashboardTabletState extends State<DashboardTablet> {
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
