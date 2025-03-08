import 'dart:math';

import 'package:flutter/material.dart';

import 'widget/home_admin/wiget_statistical.dart';

class HomeAdmin extends StatefulWidget {
  final bool isMobile  ;
  HomeAdmin({super.key , this.isMobile = false });

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
                  children: [
                    WigetStatistical(isMobile: widget.isMobile)
                  ],
                )
            ),
            !widget.isMobile ? Container(
                height: 700,
                width: min(400, MediaQuery.of(context).size.width * 0.2),
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                )
            ): Container()
          ],
        )
    );
  }
}
