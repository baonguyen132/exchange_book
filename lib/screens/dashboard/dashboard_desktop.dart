import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/home_admin.dart';
import 'package:project_admin/screens/dashboard/page/profile.dart';
import 'package:project_admin/screens/dashboard/page/test.dart';


import '../../data/ConstraintData.dart';
import 'widget/MyDrawer.dart';
import 'page/widget/home_admin/wiget_statistical.dart';

class DashboardDesktop extends StatefulWidget {
  DashboardDesktop({super.key});

  @override
  State<DashboardDesktop> createState() => _DashboardDesktopState();
}

class _DashboardDesktopState extends State<DashboardDesktop> {
  int mainPage = 4 ;
  int status = 0 ;

  Widget getPage() {
    if(mainPage == 6) {
       return HomeAdmin() ;
    }
    else if (mainPage == 4) {
      return Profile() ;
    }else if(mainPage ==3){
      return Test();
    }

    return Container() ;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Mydrawer(
                  selection: mainPage,
                  status: status,
                  handle: (item) {
                    setState(() {
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

                )
              ),
              Expanded(
                flex: 8,
                  child: getPage()
              )
            ],
          ),
        ),

    );
  }
}

