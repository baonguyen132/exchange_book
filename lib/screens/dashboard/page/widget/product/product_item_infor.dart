import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/widget/card/card_item_text.dart';

class ProductItemInfor extends StatefulWidget {
  List<dynamic> item ;
  ProductItemInfor({super.key, required this.item});

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
          CardItemText(text: widget.item[1], fontWeight: FontWeight.bold),
          SizedBox(height: 10),
          CardItemText(text: "- Còn lại: ${widget.item[10]}", fontWeight: FontWeight.normal),
          SizedBox(height: 10),
          CardItemText(text: "- Giá: ${widget.item[4]}vnd", fontWeight: FontWeight.normal),
        ],
      ),
    );
  }
  String handledesc(String text) {
    return text.replaceAll('\n', '\n+');
  }

}
