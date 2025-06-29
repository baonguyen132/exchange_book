import 'package:exchange_book/screens/dashboard/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/model/MenuModal.dart';

import 'widget/my_drawer.dart';

class DashboardDesktop extends StatefulWidget {

  final DashboardState state ;
  final Function (MenuModal item)  handle ;
  final Widget child ;


  const DashboardDesktop({
    super.key ,
    required this.handle ,
    required this.child,
    required this.state,

  });

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
                child: MyDrawer(
                  handle: (item) {
                    widget.handle(item) ;
                  },
                  state: widget.state,
                  isDesktop: true,
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

