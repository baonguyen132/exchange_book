import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:exchange_book/model/CartModal.dart';
import 'package:exchange_book/model/DetailCartModal.dart';
import 'package:exchange_book/model/UserModal.dart';
import 'package:exchange_book/screens/dashboard/page/card_detail.dart';
import 'package:exchange_book/screens/dashboard/page/widget/cart/cart_item_seller.dart';
import 'package:exchange_book/theme/theme.dart';
import 'package:exchange_book/util/wiget_textfield_custome.dart';

import '../../../data/ConstraintData.dart';

class Cart extends StatefulWidget {
  Function (Map<String, String> data,String address, String totalText, int totalSeller ,String path) handleInsert ;
  Cart({super.key , required this.handleInsert});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Map<String , String>? listSeller ;
  TextEditingController address = TextEditingController() ;
  UserModel? user ;

  Map<String, int> total = {};
  int totalSeller = 0 ;
  String totalText = "" ;
  bool isDone = false ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData() ;
  }
  void loadData() async {
    Map<String , String>? data = await DetailCartModal.loadData() ;
    UserModel? userdata = await UserModel.loadUserData() ;
    setState(() {
      listSeller = data ;
      user = userdata ;
      totalSeller = 0;
      totalText = "" ;
    });

  }
  void is_Done() async {

    if(!isDone) {
      bool condition = await true ;
      setState(() {
        isDone = condition ;
      });
    }
  }

  Widget getWidget(constraints) {
    for (var item in total.entries) {
      totalText = "$totalText-${item.value}";
      totalSeller += item.value;
    }

    return Container(
      width: constraints.maxWidth < 500
          ? constraints.maxWidth
          : constraints.maxWidth * 0.3,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Thông tin người mua",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Tên: ${user!.name}",
            style: TextStyle(fontSize: 15, color: Colors.black87),
          ),
          const SizedBox(height: 4),
          Text(
            "Email: ${user!.email}",
            style: TextStyle(fontSize: 15, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade300),

          // Tổng tiền
          const SizedBox(height: 12),
          Text(
            "Tổng tiền",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "$totalSeller",
            style: TextStyle(
              fontSize: 16,
              color: Colors.green[700],
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // TextField địa chỉ
          WigetTextfieldCustome(
            controller: address,
            textInputType: TextInputType.text,
            hint: "Nhập địa chỉ nhận",
            iconData: CupertinoIcons.location,

          ),
          const SizedBox(height: 24),

          // Button gửi
          GestureDetector(
            onTap: () {

              widget.handleInsert(
                listSeller!,
                address.text,
                totalText,
                totalSeller,
                "$location/insert_cart",
              );

            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  "Gửi",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int number = 1 ;
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: LayoutBuilder(builder: (context, constraints) => Container(

        child: Wrap(
          children: [
            Container(
                width: constraints.maxWidth < 500 ? constraints.maxWidth : constraints.maxWidth * 0.7 - 20 ,
                decoration: BoxDecoration(

                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Danh sách sản phẩm",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.maintext
                        ),
                      ),

                    ),
                    if(listSeller != null)
                      for(var item in listSeller!.entries)
                        CartItemSeller(
                          idseller: item.key,
                          exportListRaw: jsonDecode(item.value),
                          number: number++,
                          update: (idItem, idUser, value) async  {
                            await DetailCartModal.updateItem(
                              idItem,
                              idUser,
                              value,
                            );

                            setState(() {
                             // Tính tổng tiền từ dữ liệu hiện tại
                             jsonDecode(item.value).forEach((key, item_value) {
                               DetailCartModal detail = DetailCartModal.fromJson(jsonDecode(item_value));
                               if(detail.bookModal.id == idItem){
                                 total[idUser] = (total[idUser]! - (detail.quantity - value) * int.parse(detail.bookModal.price))  ;
                               }
                             });
                           });loadData();

                          },
                          delete: (idItem, idUser) async {
                            await DetailCartModal.deleteItem(idItem, idUser);

                            setState(() {
                              // Tính tổng tiền từ dữ liệu hiện tại
                              jsonDecode(item.value).forEach((key, item_value) {
                                DetailCartModal detail = DetailCartModal.fromJson(jsonDecode(item_value));
                                if(detail.bookModal.id == idItem){
                                  total[idUser] = (total[idUser]! - (detail.quantity * int.parse(detail.bookModal.price)))  ;
                                }
                              });
                            });
                            loadData();

                          },
                          onTotalUpdated: (idSeller, totalSeller, numbers) {
                            total[idSeller] = totalSeller ;

                            if(numbers >= listSeller!.length) {
                              is_Done();
                            }
                          },
                        )

                  ],
                )
            ),
            SizedBox(width: 20,) ,
            if(isDone)
              getWidget(constraints) ,
          ],
        ),
      ),),
    );
  }
}
