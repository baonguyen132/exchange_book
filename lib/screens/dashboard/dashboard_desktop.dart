
import 'package:flutter/material.dart';
import 'package:project_admin/model/MenuModal.dart';

import 'widget/MyDrawer.dart';

class DashboardDesktop extends StatefulWidget {

  int status ;
  int mainPage ;
  Function (MenuModal item)  hanlde ;
  Widget child ;
  DashboardDesktop({super.key , required this.status , required this.mainPage , required this.hanlde , required this.child});

  @override
  State<DashboardDesktop> createState() => _DashboardDesktopState();
}

class _DashboardDesktopState extends State<DashboardDesktop> {


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
                  selection: widget.mainPage,
                  status: widget.status,
                  handle: (item) {
                    widget.hanlde(item) ;
                  },

                )
              ),
              Expanded(
                flex: 8,
                  child: widget.child
              )
            ],
          ),
        ),

    );
  }
}

