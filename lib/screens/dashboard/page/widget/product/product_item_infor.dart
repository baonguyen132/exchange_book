import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/product_item_button.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/product_item_text.dart';
import 'package:project_admin/theme/theme.dart';

class ProductItemInfor extends StatefulWidget {
  const ProductItemInfor({super.key});

  @override
  State<ProductItemInfor> createState() => _ProductItemInforState();
}

class _ProductItemInforState extends State<ProductItemInfor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,

      padding: EdgeInsets.symmetric(horizontal: 5), // Thêm padding cho nội dung
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start, // Căn trái
        children: [
          ProductItemText(text: "Tiếng việt tập 1", fontWeight: FontWeight.bold),
          SizedBox(height: 10),
          ProductItemText(text: "mô tả, mô tả, mô tả, mô tả, mô tả, mô tả, mô tả,", fontWeight: FontWeight.normal),
          SizedBox(height: 10),
          ProductItemText(text: "10.000vnd", fontWeight: FontWeight.normal),
        ],
      ),
    );
  }
}
