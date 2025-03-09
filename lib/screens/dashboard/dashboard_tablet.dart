import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/home_admin.dart';
import 'package:project_admin/screens/dashboard/page/profile.dart';


import '../../data/ConstraintData.dart';
import '../../model/MenuModal.dart';
import 'widget/MyDrawer.dart';

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      drawer: Mydrawer(
        status: widget.status,
        selection: widget.mainPage,
        handle: (item) {
          Navigator.pop(context) ;
          widget.hanlde(item) ;
        },
      ),
      body: widget.child
    );
  }
}
