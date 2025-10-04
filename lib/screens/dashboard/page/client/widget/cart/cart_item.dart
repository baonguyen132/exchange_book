import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:exchange_book/data/ConstraintData.dart';
import 'package:exchange_book/model/detail_cart_modal.dart';
import 'package:exchange_book/theme/theme.dart';

import '../../../../widget/card/card_item_image.dart';
import '../../../../widget/card/card_item_text.dart';

class CartItem extends StatefulWidget {
  final String detailCartModal;
  final Function(String idItem, String idUser, int value) update;
  final Function(String idItem, String idUser) delete;
  const CartItem({
    super.key,
    required this.detailCartModal,
    required this.update,
    required this.delete,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    DetailCartModal detailCartModal =
        DetailCartModal.fromJson(jsonDecode(widget.detailCartModal));
    TextEditingController quantity =
        TextEditingController(text: detailCartModal.quantity.toString());

    String _fmt(int v) => v
        .toString()
        .replaceAllMapped(RegExp(r"\B(?=(\d{3})+(?!\d))"), (m) => ',');

    final total =
        detailCartModal.quantity * int.parse(detailCartModal.bookModal.price);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Theme.of(context).colorScheme.mainCard,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CardItemImage(
            width: 80,
            height: 80,
            borderRadius: 8,
            heart: false,
            link: "$location/${detailCartModal.bookModal.image}",
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardItemText(
                    text: detailCartModal.nameBook,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 6),
                Text('Số lượng: ${detailCartModal.quantity}',
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 4),
                Text('${_fmt(total)} VND',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),

          // Compact controls: minus / qty / plus and delete
          SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            side: BorderSide(
                                color: Theme.of(context).dividerColor)),
                        onPressed: () {
                          final cur = int.tryParse(quantity.text) ??
                              detailCartModal.quantity;
                          final next = (cur - 1) < 0 ? 0 : cur - 1;
                          quantity.text = next.toString();
                          widget.update(
                              detailCartModal.bookModal.id.toString(),
                              detailCartModal.bookModal.id_user.toString(),
                              next);
                        },
                        child: const Icon(Icons.remove, size: 18),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(quantity.text,
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                    const SizedBox(width: 6),
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            side: BorderSide(
                                color: Theme.of(context).dividerColor)),
                        onPressed: () {
                          final cur = int.tryParse(quantity.text) ??
                              detailCartModal.quantity;
                          final next = cur + 1;
                          quantity.text = next.toString();
                          widget.update(
                              detailCartModal.bookModal.id.toString(),
                              detailCartModal.bookModal.id_user.toString(),
                              next);
                        },
                        child: const Icon(Icons.add, size: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () => widget.delete(
                      detailCartModal.bookModal.id.toString(),
                      detailCartModal.bookModal.id_user.toString()),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.delete_outline,
                        color: Colors.redAccent, size: 20),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
