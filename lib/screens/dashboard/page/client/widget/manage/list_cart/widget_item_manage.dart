import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

import '../../../../../../../data/ConstraintData.dart';
import '../../../../../widget/card/card_item_image.dart';
import '../../../../../widget/card/card_item_text.dart';


class WidgetItemManage extends StatefulWidget {
  final List<dynamic> item ;
  const WidgetItemManage({super.key , required this.item});

  @override
  State<WidgetItemManage> createState() => _WidgetItemManageState();
}

class _WidgetItemManageState extends State<WidgetItemManage> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20 , vertical:10),
      padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 15),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),

          color: Theme.of(context).colorScheme.mainCard
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardItemImage(
            width: 120,
            height: 120,
            borderRadius: 10,
            heart: false,
            link: "$location/${widget.item[6]}",
          ),
          const SizedBox(width: 20,),
          Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5), // Thêm padding cho nội dung
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start, // Căn trái
                      children: [
                        CardItemText(text: widget.item[7], fontWeight: FontWeight.bold),
                        const SizedBox(height: 10),
                        CardItemText(text: "- Số lượng: ${widget.item[1]}", fontWeight: FontWeight.normal),
                        const SizedBox(height: 10),
                        CardItemText(text: "- Tổng: ${widget.item[1] * widget.item[4]}vnd", fontWeight: FontWeight.normal),
                      ],
                    ),
                  ),),
                  const SizedBox(width: 50,),

                ],
              )
          )
        ],
      ),
    );
  }
}
