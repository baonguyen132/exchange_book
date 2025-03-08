import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/home_admin.dart';
import 'package:project_admin/screens/dashboard/page/profile.dart';

import '../../data/ConstraintData.dart';
import 'widget/MyDrawer.dart';

class DashboardMobile extends StatefulWidget {
  const DashboardMobile({super.key});

  @override
  State<DashboardMobile> createState() => _DashboardMobileState();
}

class _DashboardMobileState extends State<DashboardMobile> {
  int mainPage = 4 ;
  int status = 0 ;

  Widget getPage() {
    if(mainPage == 6) {
      return HomeAdmin(isMobile: true,) ;
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
          selection: mainPage,
          status: status,
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
