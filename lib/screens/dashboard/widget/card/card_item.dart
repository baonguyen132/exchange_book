import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

import 'card_item_image.dart';

class CardItem extends StatefulWidget {
  Widget body ;
  double width ;
  bool heart ;
  String link ;
  CardItem({super.key , required this.body , required this.width, required this.heart , required this.link });

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
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
      child: Column(
        children: [
          CardItemImage(
            width: MediaQuery.of(context).size.width,
            height: 250,borderRadius: 30,
            heart: widget.heart,
            link: widget.link,
          ),
          SizedBox(height: 20,),
          widget.body
        ],
      ),
    );
  }
}
