import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/widget_text.dart';
import 'package:project_admin/theme/theme.dart';

import '../../../../../data/ConstraintData.dart';
import '../../../widget/card/card_item_image.dart';

class CardBook extends StatefulWidget {

   String link ;
   Widget child ;
   double width ;

   CardBook({super.key, required this.width , required this.link , required this.child});

  @override
  State<CardBook> createState() => _CardBookState();
}

class _CardBookState extends State<CardBook> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ,
      padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.2),
              offset: Offset(0, 3), // Bóng dịch xuống một chút
              blurRadius: 10, // Làm mềm bóng hơn
              spreadRadius: 2, // Giảm độ lan để giữ rõ viền bo
            )
          ],
          color: Theme.of(context).colorScheme.mainCard
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardItemImage(
            width: 120,
            height: 120,
            borderRadius: 10,
            heart: false,
            link: "${location}/${widget.link}",
          ),
          SizedBox(width: 20,),
          Expanded(child: widget.child)
        ],
      ),
    );
  }
}
