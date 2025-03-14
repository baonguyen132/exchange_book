import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/product_item_button.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/product_item_image.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/product_item_infor.dart';
import 'package:project_admin/theme/theme.dart';

class ProductItem extends StatefulWidget {
  ProductItem({super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 1000 ?
    Container(
      height: 240,
      width: 360,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
              color: Colors.blue,
              width: 3
          )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProductItemImage(
              width: 150,
              height: MediaQuery.of(context).size.height,
              borderRadius: const  BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              )
          ),
          ProductItemInfor(),

        ],
      ),

    )

    :

    Container(
      height: 480,
      width: 330,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
              color: Colors.blue,
              width: 3
          )
      ),
      child: Column(
        children: [
          ProductItemImage(
            width: MediaQuery.of(context).size.width,
            height: 300,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          ProductItemInfor()
        ],
      ),
    );
  }
}
