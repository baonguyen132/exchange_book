import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/product_item_button.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/product_item_infor.dart';
import 'package:project_admin/theme/theme.dart';

import '../../../../../data/ConstraintData.dart';
import '../../../widget/card/card_item_image.dart';

class BestItem extends StatefulWidget {
  List<dynamic> item ;
  Function (List<dynamic> item) openItem ;
  BestItem({super.key , required this.item, required this.openItem});

  @override
  State<BestItem> createState() => _BestItemState();
}

class _BestItemState extends State<BestItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.openItem(widget.item);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: min(MediaQuery.of(context).size.width, 550),
          margin: EdgeInsets.symmetric(horizontal: 20 , vertical:10),
          padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  offset: Offset(0, 3), // Bóng dịch xuống một chút
                  blurRadius: 10, // Làm mềm bóng hơn
                  spreadRadius: 2, // Giảm độ lan để giữ rõ viền bo
                )
              ],
              color: Theme.of(context).colorScheme.mainCard
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardItemImage(
                width: 100,
                height: 100,
                borderRadius: 10,
                heart: false,
                link: "$location/${widget.item[6]}",
              ),
              SizedBox(width: 20,),
              Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                          child: ProductItemInfor(item: widget.item,)
                      ),
                      ProductItemButton(handle: () {

                      },)
                    ],
                  )
              )
            ],
          ),
        ),
      )
    );
  }
}
