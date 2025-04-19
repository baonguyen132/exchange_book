import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_admin/model/BookModal.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/card_detail/widget_item_information_change.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/card_detail/widget_list_person_change.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/widget_text.dart';
import 'package:project_admin/screens/dashboard/widget/card/card_item_image.dart';
import 'package:project_admin/theme/theme.dart';

import '../../../../../data/ConstraintData.dart';

class WidgetCardDetail extends StatefulWidget {
  List<dynamic> item ;
  Function (BookModal bookModal) editItem ;
  Function (BookModal bookModal) deleteItem ;

  WidgetCardDetail({
    super.key ,
    required this.item,
    required this.editItem,
    required this.deleteItem
  });

  @override
  State<WidgetCardDetail> createState() => _WidgetCardDetailState();
}

class _WidgetCardDetailState extends State<WidgetCardDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) => Wrap(
      children: [
        Container(
          width: constraints.maxWidth < 850 ? constraints.maxWidth : constraints.maxWidth * 0.7,
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              WidgetItemInformationChange(
                item: widget.item,
                editItem: (bookModal) {
                  widget.editItem(bookModal) ;
                },
                deleteItem: (bookModal) {
                  widget.deleteItem(bookModal) ;
                },
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
          child: WidgetListPersonChange(
              change: () {

              },
              nochange: () {

              },
          ),
        )
      ],
    ),);
  }
}
