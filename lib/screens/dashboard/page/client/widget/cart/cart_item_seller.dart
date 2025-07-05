import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

import '../../../../../../model/DetailCartModal.dart';
import 'cart_item.dart';


class CartItemSeller extends StatefulWidget {
  final String idSeller ;
  final Map<String, dynamic> exportListRaw ;
  final Function (String idItem , String idUser, int value) update ;
  final Function (String idItem , String idUser) delete ;
  final int number ;

  final Function(String idSeller,int totalSeller, int quantityList) onTotalUpdated; // Callback function to pass the total

  const CartItemSeller({super.key ,
    required this.idSeller,
    required this.exportListRaw,
    required this.update,
    required this.delete,
    required this.onTotalUpdated,
    required this.number
  });

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

    widget.onTotalUpdated(widget.idSeller,totalItem, widget.number) ;

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.blue.shade400,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 3,
                spreadRadius: 3,
                offset: const Offset(0, 0),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10),
              for (var item in widget.exportListRaw.entries)
                CartItem(
                  detailCartModal: item.value,
                  update: (idItem, idUser, value) {widget.update(idItem, idUser, value);},
                  delete: (idItem, idUser) {widget.delete(idItem, idUser);},
                ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Tổng tiền: $totalItem VND",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.maintext,
                  ),
                )
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
