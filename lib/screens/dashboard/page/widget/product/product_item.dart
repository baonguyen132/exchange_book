import 'package:flutter/cupertino.dart';
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
    return Container(
      width: 300,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
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
      child: Column(
        children: [
          ProductItemImage(
            width: MediaQuery.of(context).size.width,
            height: 250,
          ),
          SizedBox(height: 20,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  child: ProductItemInfor()
              ),
              ProductItemButton(hanlde: () {

              },)
            ],
          )
        ],
      ),
    );
  }
}
