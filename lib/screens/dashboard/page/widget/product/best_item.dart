import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/product_item_button.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/product_item_infor.dart';

import '../../../widget/card/card_item_image.dart';

class BestItem extends StatefulWidget {
  const BestItem({super.key});

  @override
  State<BestItem> createState() => _BestItemState();
}

class _BestItemState extends State<BestItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: min(MediaQuery.of(context).size.width, 500),
      margin: EdgeInsets.symmetric(horizontal: 20 , vertical:10),
      padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(0, 3), // Bóng dịch xuống một chút
              blurRadius: 10, // Làm mềm bóng hơn
              spreadRadius: 2, // Giảm độ lan để giữ rõ viền bo
            )
          ],
          color: Colors.white
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardItemImage(
            width: 100,
            height: 100,
            borderRadius: 10,
            heart: false,
            link: "https://nld.mediacdn.vn/2020/9/7/anh-1-15994611977581569666831.gif",
          ),
          SizedBox(width: 20,),
          Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: ProductItemInfor()
                  ),
                  ProductItemButton(handle: () {

                  },)
                ],
              )
          )
        ],
      ),
    );
  }
}
