import 'dart:math';

import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

class WidgetButtonCardDetailOfProduct extends StatefulWidget {
  final Function () change ;
  const WidgetButtonCardDetailOfProduct({super.key , required this.change});

  @override
  State<WidgetButtonCardDetailOfProduct> createState() => _WidgetButtonCardDetailOfProductState();
}

class _WidgetButtonCardDetailOfProductState extends State<WidgetButtonCardDetailOfProduct> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {widget.change() ;},
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: MediaQuery.of(context).size.width < 500 ? MediaQuery.of(context).size.width : 150,
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: Colors.blue,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              "Đặt mua",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.maintext
              ),
            ),
          )
        ),
      ),
    );
  }
}
