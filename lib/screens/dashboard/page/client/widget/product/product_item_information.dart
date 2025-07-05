import 'package:flutter/material.dart';
import 'package:exchange_book/screens/dashboard/widget/card/card_item_text.dart';

class ProductItemInformation extends StatefulWidget {
  final List<dynamic> item ;
  const ProductItemInformation({super.key, required this.item});

  @override
  State<ProductItemInformation> createState() => _ProductItemInformationState();
}

class _ProductItemInformationState extends State<ProductItemInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,

      padding: const EdgeInsets.symmetric(horizontal: 5), // Thêm padding cho nội dung
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start, // Căn trái
        children: [
          CardItemText(text: widget.item[1], fontWeight: FontWeight.bold),
          const SizedBox(height: 10),
          CardItemText(text: "- Còn lại: ${widget.item[10]}", fontWeight: FontWeight.normal),
          const SizedBox(height: 10),
          CardItemText(text: "- Giá: ${widget.item[4]}vnd", fontWeight: FontWeight.normal),
        ],
      ),
    );
  }
  String handleDesc(String text) {
    return text.replaceAll('\n', '\n+');
  }

}
