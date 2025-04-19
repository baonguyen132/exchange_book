import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_admin/model/BookModal.dart';
import 'package:project_admin/screens/dashboard/page/widget/card_detail/widget_item_information_change.dart';
import 'package:project_admin/screens/dashboard/page/widget/card_detail/widget_list.dart';
import 'package:project_admin/theme/theme.dart';

import '../../../data/ConstraintData.dart';

class CardDetail extends StatefulWidget {
  List<dynamic> item ;
  Widget wigetHasListButton ;

  String titleRight ;
  Widget list ;

  CardDetail({
    super.key ,
    required this.item,
    required this.wigetHasListButton,
    required this.titleRight,
    required this.list
  });

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) => Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: [
        Container(
            width: constraints.maxWidth < 850 ? constraints.maxWidth : constraints.maxWidth * 0.7 ,
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                WidgetItemInformationChange(
                  item: widget.item,
                  widget_button: widget.wigetHasListButton,
                ),

              ],
            )
        ),

        Container(
          width: constraints.maxWidth < 850 ? constraints.maxWidth : constraints.maxWidth * 0.3,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).colorScheme.mainCard,
            boxShadow: [
              BoxShadow(
                  color: Colors.blue.shade100,
                  offset: Offset(0, 0),
                  spreadRadius: 2,
                  blurRadius: 2
              )
            ],
          ),
          child: WidgetList(
            title: widget.titleRight,
            list: widget.list,
          ),
        )
      ],
    ),);
  }
}
