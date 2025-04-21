import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/widget/cart/cart_item.dart';
import 'package:project_admin/theme/theme.dart';

import '../../../../../data/ConstraintData.dart';
import '../../../../../model/DetailCartModal.dart';
import '../../../widget/card/card_item_image.dart';

class CartItemSeller extends StatefulWidget {
  String idseller ;
  Map<String, dynamic> exportListRaw ;
  Function (String idItem , String idUser, int value) update ;
  Function (String idItem , String idUser) delete ;
  int number ;

  final Function(String idSeller,int totalSeller, int quantity_list) onTotalUpdated; // Callback function to pass the total

  CartItemSeller({super.key ,
    required this.idseller,
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

  Widget build(BuildContext context) {
    int totalItem = 0;

    // Tính tổng tiền từ dữ liệu hiện tại
    widget.exportListRaw.forEach((key, value) {
      DetailCartModal detail = DetailCartModal.fromJson(jsonDecode(value));
      totalItem += detail.quantity * int.parse(detail.bookModal.price);
    });

    widget.onTotalUpdated(widget.idseller,totalItem, widget.number) ;

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.blue.shade400,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 3,
                spreadRadius: 3,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Tên: ${widget.idseller}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.maintext,
                  ),
                ),
              ),
              SizedBox(height: 10),
              for (var item in widget.exportListRaw.entries)
                CartItem(
                  detailCartModal: item.value,
                  update: (idItem, idUser, value) {
                    widget.update(idItem, idUser, value);
                    setState(() {}); // Gọi lại build để cập nhật tổng tiền
                  },
                  delete: (idItem, idUser) {
                    widget.delete(idItem, idUser);
                     // Gọi lại build để cập nhật tổng tiền
                  },
                ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Tổng tiền: $totalItem VND",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.maintext,
                  ),
                )
              ),
              SizedBox(height: 10),

            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
