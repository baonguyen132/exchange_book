import 'package:flutter/material.dart';
import 'package:project_admin/model/TypeBookModal.dart';

import '../../../widget/card/card_item_text.dart';

class CardTypeBookInfor extends StatefulWidget {

  TypeBookModal typeBookModal ;
  CardTypeBookInfor({super.key , required this.typeBookModal});

  @override
  State<CardTypeBookInfor> createState() => _CardTypeBookInforState();
}

class _CardTypeBookInforState extends State<CardTypeBookInfor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,

      padding: EdgeInsets.symmetric(horizontal: 5), // Thêm padding cho nội dung
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start, // Căn trái
        children: [
          CardItemText(text: widget.typeBookModal.name_book, fontWeight: FontWeight.bold),
          SizedBox(height: 10),
          CardItemText(text: widget.typeBookModal.type_book, fontWeight: FontWeight.bold),
          SizedBox(height: 10),
          CardItemText(text: widget.typeBookModal.price, fontWeight: FontWeight.normal),
          SizedBox(height: 10,),
          CardItemText(text: widget.typeBookModal.description, fontWeight: FontWeight.normal),
          SizedBox(height: 20,),


        ],
      ),
    );
  }
}
