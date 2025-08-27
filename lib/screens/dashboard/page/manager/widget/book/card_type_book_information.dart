import 'package:flutter/material.dart';
import 'package:exchange_book/model/type_book_modal.dart';

import '../../../../widget/card/card_item_text.dart';


class CardTypeBookInformation extends StatefulWidget {

  final TypeBookModal typeBookModal ;
  const CardTypeBookInformation({super.key , required this.typeBookModal});

  @override
  State<CardTypeBookInformation> createState() => _CardTypeBookInformationState();
}

class _CardTypeBookInformationState extends State<CardTypeBookInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,

      padding: const EdgeInsets.symmetric(horizontal: 5), // Thêm padding cho nội dung
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start, // Căn trái
        children: [
          CardItemText(text: widget.typeBookModal.name_book, fontWeight: FontWeight.bold),
          const SizedBox(height: 10),
          CardItemText(text: widget.typeBookModal.type_book, fontWeight: FontWeight.bold),
          const SizedBox(height: 10),
          CardItemText(text: widget.typeBookModal.price, fontWeight: FontWeight.normal),
          const SizedBox(height: 10,),
          CardItemText(text: widget.typeBookModal.description, fontWeight: FontWeight.normal),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
