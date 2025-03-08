import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/home_admin.dart';
import 'package:project_admin/screens/dashboard/page/profile.dart';


import '../../data/ConstraintData.dart';
import 'widget/MyDrawer.dart';

class DashboardTablet extends StatefulWidget {
  DashboardTablet({super.key});
  @override
  State<DashboardTablet> createState() => _DashboardTabletState();
}

class _DashboardTabletState extends State<DashboardTablet> {
  int mainPage = 4 ;
  int status = 0 ;

  Widget getPage() {
    if(mainPage == 6) {
      return HomeAdmin() ;
    }
    else if (mainPage == 4) {
      return Profile() ;
    }

    return Container() ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      drawer: Mydrawer(
        status: status,
        selection: mainPage,
        handle: (item) {
          setState(() {
            Navigator.pop(context) ;
            if(item.title == "Admin") {
              status = 1 ;
              mainPage = item.id + 1;
            }
            else if(item.title == "Client") {
              status = 0 ;
              mainPage = 1 ;
            }
            else {
              mainPage = item.id;
            }
          });
        },
      ),
      body: getPage()
    );
  }
}
