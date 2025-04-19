import 'package:flutter/material.dart';
import 'package:project_admin/data/ConstraintData.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/product_item_button.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/product_item_infor.dart';
import 'package:project_admin/screens/dashboard/widget/card/card_item.dart';

class ProductItem extends StatefulWidget {
  List<dynamic> item ;
  Function (List<dynamic> item) openItem ;
  ProductItem({super.key, required this.item , required this.openItem});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.openItem(widget.item) ;
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: CardItem(
            width: 300,
            heart: true,
            link: "$location/${widget.item[6]}",
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: ProductItemInfor(item:  widget.item,)
                ),
                ProductItemButton(handle: () {

                },)
              ],
            )
        ),
      ),
    );
  }
}
