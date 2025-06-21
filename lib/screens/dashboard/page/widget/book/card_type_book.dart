import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/data/ConstraintData.dart';
import 'package:exchange_book/model/TypeBookModal.dart';
import 'package:exchange_book/screens/dashboard/page/widget/book/card_type_book_button.dart';
import 'package:exchange_book/screens/dashboard/page/widget/book/card_type_book_infor.dart';
import 'package:exchange_book/screens/dashboard/page/widget/book/card_type_mobile.dart';

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
    return MediaQuery.of(context).size.width < 500 ?
    CardTypeMobile(
        typeBookModal: widget.typeBookModal,
        delete: (typeBookModal) {
          widget.delete(widget.typeBookModal);
        },
        edit: (typeBookModal) {
           widget.edit(widget.typeBookModal) ;
        },)
        :
    CardItem(
        width:  350,
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
