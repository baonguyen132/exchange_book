import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

import '../../../../../../data/ConstraintData.dart';
import '../../../../widget/card/card_item_image.dart';
import '../product_item_button.dart';
import '../product_item_infor.dart';

class WidgetItemProduct extends StatefulWidget {
  double width ;
  List<dynamic> item ;
  Function (List<dynamic> item) openItem ;
  WidgetItemProduct({super.key, required this.width , required this.item, required this.openItem});

  @override
  State<WidgetItemProduct> createState() => _WidgetItemProductState();
}

class _WidgetItemProductState extends State<WidgetItemProduct> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.openItem(widget.item) ;
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(bottom: 15),
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(width: 1 , color: Colors.blue.shade300),
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
              Expanded(child: ProductItemInfor(item: widget.item,))
            ],
          ),
        ),
      ),
    );
  }
}
