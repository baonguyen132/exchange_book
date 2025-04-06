import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/product_item_button.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/product_item_infor.dart';
import 'package:project_admin/screens/dashboard/widget/card/card_item.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return CardItem(
        width: 350,
        heart: true,
        link: "https://nld.mediacdn.vn/2020/9/7/anh-1-15994611977581569666831.gif",
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: ProductItemInfor()
            ),
            ProductItemButton(handle: () {

            },)
          ],
        )
    );
  }
}
