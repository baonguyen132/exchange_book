import 'dart:math';

import 'package:flutter/material.dart';


import '../../data/ConstraintData.dart';
import 'widget/MyDrawer.dart';
import 'widget/wiget_statistical.dart';

class DashboardDesktop extends StatefulWidget {
  DashboardDesktop({super.key});

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
                  child: SingleChildScrollView(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                              child: Column(
                                children: [
                                  WigetStatistical()
                                ],
                              )
                          ),
                          Container(
                              height: 700,
                              width: min(400, MediaQuery.of(context).size.width * 0.2),
                              padding: EdgeInsets.all(10),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.all(Radius.circular(8))
                                ),
                              ))
                        ],
                      )
                  )
              )
            ],
          ),
        ),

    );
  }
}

