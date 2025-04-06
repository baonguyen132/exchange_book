import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/widget/bottom_nav_bar.dart';
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
