import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

import '../../../../../../model/detail_cart_modal.dart';
import 'cart_item.dart';

class CartItemSeller extends StatefulWidget {
  final String idSeller;
  final Map<String, dynamic> exportListRaw;
  final Function(String idItem, String idUser, int value) update;
  final Function(String idItem, String idUser) delete;
  final int number;

  final Function(String idSeller, int totalSeller, int quantityList)
      onTotalUpdated; // Callback function to pass the total

  const CartItemSeller(
      {super.key,
      required this.idSeller,
      required this.exportListRaw,
      required this.update,
      required this.delete,
      required this.onTotalUpdated,
      required this.number});

  @override
  State<CartItemSeller> createState() => _CartItemSellerState();
}

class _CartItemSellerState extends State<CartItemSeller> {
  @override
  Widget build(BuildContext context) {
    int totalItem = 0;

    // Tính tổng tiền từ dữ liệu hiện tại
    widget.exportListRaw.forEach((key, value) {
      DetailCartModal detail = DetailCartModal.fromJson(jsonDecode(value));
      totalItem += detail.quantity * int.parse(detail.bookModal.price);
    });

    widget.onTotalUpdated(widget.idSeller, totalItem, widget.number);

    String _formatCurrency(int value) {
      final s = value.toString();
      final reg = RegExp(r"\B(?=(\d{3})+(?!\d))");
      return s.replaceAllMapped(reg, (m) => ',');
    }

    final int itemCount = widget.exportListRaw.length;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(
                color: Theme.of(context).dividerColor.withOpacity(0.08)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Seller header (flat)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(
                      widget.idSeller.isNotEmpty
                          ? widget.idSeller[0].toUpperCase()
                          : 'S',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Người bán: ${widget.idSeller}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 2),
                        Text('$itemCount mục',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.black54)),
                      ],
                    ),
                  ),
                  // Optional small action per seller (kept neutral)
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6)),
                    child: Text('Liên hệ',
                        style:
                            TextStyle(color: Theme.of(context).primaryColor)),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Items list with divider
              Column(
                children: [
                  for (var entry in widget.exportListRaw.entries)
                    Column(
                      children: [
                        CartItem(
                          detailCartModal: entry.value,
                          update: (idItem, idUser, value) {
                            widget.update(idItem, idUser, value);
                          },
                          delete: (idItem, idUser) {
                            widget.delete(idItem, idUser);
                          },
                        ),
                        const Divider(height: 10),
                      ],
                    ),
                ],
              ),

              const SizedBox(height: 6),

              // Total row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tổng cộng',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.black54)),
                  Text('${_formatCurrency(totalItem)} VND',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold))
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
