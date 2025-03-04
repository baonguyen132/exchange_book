import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/profile.dart';

import '../../data/ConstraintData.dart';
import 'widget/MyDrawer.dart';

class DashboardMobile extends StatefulWidget {
  const DashboardMobile({super.key});

  @override
  State<DashboardMobile> createState() => _DashboardMobileState();
}

class _DashboardMobileState extends State<DashboardMobile> {
  int mainPage = 2 ;

  Widget getPage() {
    if(mainPage == 1) {
      return ListView(
          children: [
            Container(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: GridView.builder(
                      itemCount: 4,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          color: Colors.green,
                        ),

                      ),
                    ),
                  ),
                ],
              ),
            )
          ]
      );
    }
    else if (mainPage == 2) {
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
          handle: (page) {
            setState(() {
              Navigator.pop(context) ;
              mainPage = page ;
            });
          },
        ),
        body: getPage()
    );
  }
}
