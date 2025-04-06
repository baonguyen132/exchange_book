import 'package:flutter/material.dart';
import 'package:project_admin/model/MenuModal.dart';
import 'package:project_admin/screens/dashboard/page/book.dart';
import 'package:project_admin/screens/dashboard/page/home.dart';
import 'package:project_admin/screens/dashboard/page/product.dart';

import '../../model/TypeBookModal.dart';
import '../../util/responsive.dart';
import 'dashboard_desktop.dart';
import 'dashboard_mobile.dart';
import 'dashboard_tablet.dart';
import 'page/home_admin.dart';
import 'page/profile.dart';
import 'page/history.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int mainPage = 1 ;
  int status = 0 ;

  Widget getPage(bool isMobile) {
    if(mainPage == 6) {
      return HomeAdmin(isMobile: isMobile,) ;
    }
    else if(mainPage == 2) {
      return Product() ;
    }
    else if (mainPage == 4) {
      return Profile() ;
    }else if(mainPage ==3){
      return History();
    }else if(mainPage ==1){
      return Home();
    }
    else if(mainPage == 7) {
      return Book();
    }
    return Container() ;
  }

  @override
  Widget build(BuildContext context) {

    void handle(MenuModal item) {
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
    }

    return Responsive(
        desktop: DashboardDesktop(
          status: status,
          mainPage: mainPage,
          hanlde: (item) {
            handle(item);
          },
          child:  getPage(false),
        ),
        mobile: DashboardMobile(
          status: status,
          mainPage: mainPage,
          hanlde: (item) {
            handle(item);
          },
          child: getPage(true),
        ),
        tablet: DashboardTablet(
          status: status,
          mainPage: mainPage,
          hanlde: (item) {
            handle(item);
          },
          child: getPage(false),
        )
    );
  }
}
