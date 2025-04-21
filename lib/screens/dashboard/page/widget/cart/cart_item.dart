import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_admin/data/ConstraintData.dart';
import 'package:project_admin/model/DetailCartModal.dart';
import 'package:project_admin/theme/theme.dart';
import 'package:project_admin/util/wiget_textfield_custome.dart';

import '../../../widget/card/card_item_image.dart';
import '../../../widget/card/card_item_text.dart';

class CartItem extends StatefulWidget {
  String detailCartModal ;
  Function (String idItem , String idUser, int value) update ;
  Function (String idItem , String idUser) delete ;
  CartItem({super.key,
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
      margin: EdgeInsets.symmetric(horizontal: 20 , vertical:10),
      padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),

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
          SizedBox(width: 20,),
          Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5), // Thêm padding cho nội dung
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start, // Căn trái
                      children: [
                        CardItemText(text: detailCartModal.name_book, fontWeight: FontWeight.bold),
                        SizedBox(height: 10),
                        CardItemText(text: "- Số lượng: ${detailCartModal.quantity}", fontWeight: FontWeight.normal),
                        SizedBox(height: 10),
                        CardItemText(text: "- Tổng: ${detailCartModal.quantity * int.parse(detailCartModal.bookModal.price)}vnd", fontWeight: FontWeight.normal),
                      ],
                    ),
                  ),),
                  SizedBox(width: 50,),
                  Container(
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
                          onChanged: (value) async {
                            int? newQuantity = int.tryParse(value);
                            if (newQuantity != null && newQuantity >= 0) {
                              // Cập nhật vào SharedPreferences
                              widget.update(
                                detailCartModal.bookModal.id.toString(),
                                detailCartModal.bookModal.id_user.toString(),
                                newQuantity,
                              );

                              // Cập nhật lại giao diện

                            }
                          },
                        ),

                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: () async {
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
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                    offset: Offset(0, 1),
                                  )
                                ],
                              ),
                              height: 50,
                              alignment: Alignment.center,
                              child: Icon(Icons.close, color: Colors.white,),
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
