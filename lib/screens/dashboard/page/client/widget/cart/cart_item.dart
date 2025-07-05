import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:exchange_book/data/ConstraintData.dart';
import 'package:exchange_book/model/DetailCartModal.dart';
import 'package:exchange_book/theme/theme.dart';

import '../../../../widget/card/card_item_image.dart';
import '../../../../widget/card/card_item_text.dart';


class CartItem extends StatefulWidget {
  final String detailCartModal ;
  final Function (String idItem , String idUser, int value) update ;
  final Function (String idItem , String idUser) delete ;
  const CartItem({super.key,
    required this.detailCartModal,
    required this.update , required
    this.delete,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {



  @override
  Widget build(BuildContext context) {
    DetailCartModal detailCartModal = DetailCartModal.fromJson(jsonDecode(widget.detailCartModal));
    TextEditingController quantity = TextEditingController(text: detailCartModal.quantity.toString());

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20 , vertical:10),
      padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 15),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).colorScheme.mainCard
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardItemImage(
            width: 120,
            height: 120,
            borderRadius: 10,
            heart: false,
            link: "$location/${detailCartModal.bookModal.image}",
          ),
          const SizedBox(width: 20,),
          Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5), // Thêm padding cho nội dung
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start, // Căn trái
                      children: [
                        CardItemText(text: detailCartModal.nameBook, fontWeight: FontWeight.bold),
                        const SizedBox(height: 10),
                        CardItemText(text: "- Số lượng: ${detailCartModal.quantity}", fontWeight: FontWeight.normal),
                        const SizedBox(height: 10),
                        CardItemText(text: "- Tổng: ${detailCartModal.quantity * int.parse(detailCartModal.bookModal.price)}vnd", fontWeight: FontWeight.normal),
                      ],
                    ),
                  ),),
                  const SizedBox(width: 50,),
                  SizedBox(
                    width: 50,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: quantity,
                          keyboardType: TextInputType.number, // Đúng hơn là number thay vì text
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          onChanged: (value) {
                            int? newQuantity = int.tryParse(value);
                            if (newQuantity != null && newQuantity >= 0) {
                              // Cập nhật vào SharedPreferences
                              widget.update(
                                detailCartModal.bookModal.id.toString(),
                                detailCartModal.bookModal.id_user.toString(),
                                newQuantity,
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 20,),
                        GestureDetector(
                          onTap: ()  {
                            widget.delete(
                                detailCartModal.bookModal.id.toString(),
                                detailCartModal.bookModal.id_user.toString()
                            );
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 1),
                                  )
                                ],
                              ),
                              height: 50,
                              alignment: Alignment.center,
                              child: const Icon(Icons.close, color: Colors.white,),
                            ),
                          ),
                        )

                      ],
                    ),
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}
