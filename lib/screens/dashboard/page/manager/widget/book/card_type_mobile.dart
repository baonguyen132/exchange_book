import 'dart:math';

import 'package:flutter/material.dart';
import 'package:exchange_book/data/ConstraintData.dart';
import 'package:exchange_book/model/TypeBookModal.dart';
import 'package:exchange_book/theme/theme.dart';

import '../../../../widget/card/card_item_image.dart';
import 'card_type_book_button.dart';
import 'card_type_book_infor.dart';

class CardTypeMobile extends StatefulWidget {
  TypeBookModal typeBookModal ;
  Function (TypeBookModal typeBookModal) edit ;
  Function (TypeBookModal typeBookModal) delete ;

  CardTypeMobile({super.key , required this.typeBookModal , required this.delete , required this.edit});

  @override
  State<CardTypeMobile> createState() => _CardTypeMobileState();
}

class _CardTypeMobileState extends State<CardTypeMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: min(MediaQuery.of(context).size.width, 500),
      margin: EdgeInsets.symmetric(horizontal: 10 , vertical:10),
      padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              offset: Offset(0, 3), // Bóng dịch xuống một chút
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
          SizedBox(width: 20,),
          Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: CardTypeBookInfor(typeBookModal: widget.typeBookModal)
                  ),
                  Column(
                    children: [
                      CardTypeBookButton(
                        color: Colors.blue,
                        iconData: Icons.edit,
                        handle: () {
                          widget.edit(widget.typeBookModal);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CardTypeBookButton(
                        color: Colors.red,
                        iconData: Icons.close,
                        handle: () {
                          widget.delete(widget.typeBookModal) ;
                        },
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
