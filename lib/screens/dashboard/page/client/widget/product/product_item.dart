import 'package:exchange_book/screens/dashboard/page/client/widget/product/product_item_button.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/product/product_item_information.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/data/ConstraintData.dart';
import 'package:exchange_book/model/BookModal.dart';
import 'package:exchange_book/screens/dashboard/widget/card/card_item.dart';

class ProductItem extends StatefulWidget {
  final List<dynamic> item ;
  final Function (List<dynamic> item) openItem ;
  final Function (BookModal bookModal, String nameBook) order ;
  const ProductItem({super.key, required this.item , required this.openItem, required this.order});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {widget.openItem(widget.item) ;},
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: CardItem(
            width: 300,
            heart: true,
            link: "$location/${widget.item[6]}",
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: ProductItemInformation(item:  widget.item,)
                ),
                ProductItemButton(handle: () {
                  widget.order(
                      BookModal(
                          id: widget.item[0].toString(),
                          date_purchase: widget.item[3],
                          price: widget.item[4].toString(),
                          description: widget.item[5],
                          status: widget.item[9].toString(),
                          image: widget.item[6],
                          quantity: widget.item[10].toString(),
                          id_user: widget.item[7].toString(),
                          id_type_book: widget.item[8].toString()
                      ),
                      widget.item[1]
                  );
                },)
              ],
            )
        ),
      ),
    );
  }
}
