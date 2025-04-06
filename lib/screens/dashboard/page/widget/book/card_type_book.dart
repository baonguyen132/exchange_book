import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_admin/data/ConstraintData.dart';
import 'package:project_admin/model/TypeBookModal.dart';
import 'package:project_admin/screens/dashboard/page/widget/book/card_type_book_button.dart';
import 'package:project_admin/screens/dashboard/page/widget/book/card_type_book_infor.dart';

import '../../../widget/card/card_item.dart';

class CardTypeBook extends StatefulWidget {
  TypeBookModal typeBookModal ;
  Function (TypeBookModal typeBookModal) edit ;
  Function (TypeBookModal typeBookModal) delete ;

  CardTypeBook({super.key , required this.typeBookModal , required this.edit , required this.delete});

  @override
  State<CardTypeBook> createState() => _CardTypeBookState();
}

class _CardTypeBookState extends State<CardTypeBook> {
  @override
  Widget build(BuildContext context) {
    return CardItem(
        width: MediaQuery.of(context).size.width < 500 ? MediaQuery.of(context).size.width : 350,
        heart: false,
        link: location+widget.typeBookModal.image,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: CardTypeBookInfor(typeBookModal: widget.typeBookModal,)
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
                SizedBox(
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
    );
  }
}
