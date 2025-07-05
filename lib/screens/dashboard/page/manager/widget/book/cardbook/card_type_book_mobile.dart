import 'dart:math';

import 'package:flutter/material.dart';
import 'package:exchange_book/data/ConstraintData.dart';
import 'package:exchange_book/model/TypeBookModal.dart';
import 'package:exchange_book/theme/theme.dart';

import '../../../../../widget/card/card_item_image.dart';
import '../card_type_book_button.dart';
import '../card_type_book_information.dart';

class CardTypeBookMobile extends StatefulWidget {
  final TypeBookModal typeBookModal ;
  final Function (TypeBookModal typeBookModal) edit ;
  final Function (TypeBookModal typeBookModal) delete ;

  const CardTypeBookMobile({
    super.key,
    required this.typeBookModal,
    required this.delete,
    required this.edit
  });

  @override
  State<CardTypeBookMobile> createState() => _CardTypeBookMobileState();
}

class _CardTypeBookMobileState extends State<CardTypeBookMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: min(MediaQuery.of(context).size.width, 500),
      margin: const EdgeInsets.symmetric(horizontal: 10 , vertical:10),
      padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 15),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              offset: const Offset(0, 3), // Bóng dịch xuống một chút
              blurRadius: 10, // Làm mềm bóng hơn
              spreadRadius: 2, // Giảm độ lan để giữ rõ viền bo
            )
          ],
          color: Theme.of(context).colorScheme.mainCard
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardItemImage(
            width: 100,
            height: 100,
            borderRadius: 10,
            heart: false,
            link: "$location/${widget.typeBookModal.image}",
          ),
          const SizedBox(width: 20,),
          Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: CardTypeBookInformation(typeBookModal: widget.typeBookModal)),
                  Column(
                    children: [
                      CardTypeBookButton(
                        color: Colors.blue,
                        iconData: Icons.edit,
                        handle: () {widget.edit(widget.typeBookModal);},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CardTypeBookButton(
                        color: Colors.red,
                        iconData: Icons.close,
                        handle: () {widget.delete(widget.typeBookModal) ;},
                      )
                    ],
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}
