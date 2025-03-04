import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/home.dart';
import 'package:project_admin/screens/dashboard/page/profile.dart';


import '../../data/ConstraintData.dart';
import 'widget/MyDrawer.dart';
import 'widget/wiget_statistical.dart';

class DashboardDesktop extends StatefulWidget {
  DashboardDesktop({super.key});

  @override
  State<DashboardDesktop> createState() => _DashboardDesktopState();
}

class _DashboardDesktopState extends State<DashboardDesktop> {
  int mainPage = 2 ;

  Widget getPage() {
    if(mainPage == 1) {
       return Home() ;
    }
    else if (mainPage == 2) {
      return Profile() ;
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
                  handle: (page) {
                    setState(() {
                      mainPage = page ;
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

