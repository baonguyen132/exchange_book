import 'package:flutter/material.dart';

import 'widget_box.dart';

class WigetStatistical extends StatefulWidget {
  const WigetStatistical({super.key});

  @override
  State<WigetStatistical> createState() => _WigetStatisticalState();
}

class _WigetStatisticalState extends State<WigetStatistical> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 ,
      child: GridView.builder(
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemBuilder: (context, index) => WidgetBox(
            index: index,
            child: Container(),
          )
      ),
    );
  }
}
