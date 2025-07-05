import 'dart:math';

import 'package:exchange_book/screens/dashboard/page/client/widget/card_detail/widget_item_information_change.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/card_detail/widget_list.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

import '../../../../data/ConstraintData.dart';

class CardDetail extends StatefulWidget {
  final List<dynamic> item ;
  final Widget widgetHasListButton ;

  final String titleRight ;
  final Widget list ;

  const CardDetail({
    super.key ,
    required this.item,
    required this.widgetHasListButton,
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
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                WidgetItemInformationChange(
                  item: widget.item,
                  widgetButton: widget.widgetHasListButton,
                ),

              ],
            )
        ),

        Container(
          width: constraints.maxWidth < 850 ? constraints.maxWidth : constraints.maxWidth * 0.3,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).colorScheme.mainCard,
            boxShadow: [
              BoxShadow(
                  color: Colors.blue.shade100,
                  offset: const Offset(0, 0),
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
