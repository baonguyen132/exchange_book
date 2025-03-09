import 'package:flutter/material.dart';

import 'widget_box.dart';

class WigetStatistical extends StatefulWidget {
  final bool isMobile ;
  WigetStatistical({super.key , this.isMobile = false});

  @override
  State<WigetStatistical> createState() => _WigetStatisticalState();
}

class _WigetStatisticalState extends State<WigetStatistical> {
  int choosed = 0 ;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: !widget.isMobile ? 4 : 1 ,
      child: GridView.builder(
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: !widget.isMobile ? 4 : 2),
          itemBuilder: (context, index) => WidgetBox(
            condition: choosed == index,
            child: Container(),
            handle: () {
              setState(() {
                choosed = index ;
              });
            },
          )
      ),
    );
  }
}
