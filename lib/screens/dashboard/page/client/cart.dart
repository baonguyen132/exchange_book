import 'dart:convert';

import 'package:exchange_book/screens/dashboard/page/client/cubit/cart/cart_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/cart/cart_item_seller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/model/detail_cart_modal.dart';
import 'package:exchange_book/model/user_modal.dart';
import 'package:exchange_book/theme/theme.dart';
import 'package:exchange_book/util/widget_text_field_custom.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/ConstraintData.dart';



class Cart extends StatefulWidget {
  final Function (Map<String, String> data,String address, String totalText, int totalSeller ,String path) handleInsert ;
  final UserModel userModel ;
  const Cart({super.key , required this.handleInsert, required this.userModel});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  late CartCubit cartCubit ;
  late TextEditingController address  ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartCubit = CartCubit() ;
    address = TextEditingController(text: cartCubit.state.address);
    cartCubit.loadData() ;
    cartCubit.loadTotal();
  }


  Widget getWidget(constraints , CartState state) {


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
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Thông tin người mua",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Tên: ${widget.userModel.name}",
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
          const SizedBox(height: 4),
          Text(
            "Email: ${widget.userModel.email}",
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade300),

          // Tổng tiền
          const SizedBox(height: 12),
          const Text(
            "Tổng tiền",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "${state.totalSeller}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.green[700],
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // TextField địa chỉ
          WidgetTextFieldCustom(
            controller: address,
            textInputType: TextInputType.text,
            hint: "Nhập địa chỉ nhận",
            iconData: CupertinoIcons.location,

          ),
          const SizedBox(height: 24),

          // Button gửi
          GestureDetector(
            onTap: () {widget.handleInsert(state.listSeller!, address.text, state.totalText, state.totalSeller, "$location/insert_cart",);},
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
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Text(
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
    return BlocBuilder<CartCubit , CartState>(
      bloc: cartCubit,
      builder: (context, state) => LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Wrap(
                children: [
                  SizedBox(
                      width: constraints.maxWidth < 500 ? constraints.maxWidth : constraints.maxWidth * 0.7 - 50 ,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              "Danh sách sản phẩm",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.maintext
                              ),
                            ),

                          ),
                          if(state.listSeller != null)
                            for(var item in state.listSeller!.entries)
                              CartItemSeller(
                                idSeller: item.key,
                                exportListRaw: jsonDecode(item.value),
                                number: number++,
                                update: (idItem, idUser, value) async  {
                                  await DetailCartModal.updateItem(idItem, idUser, value,);
                                  cartCubit.updateItemCart(item: item, idItem: idItem, idUser: idUser, value: value);
                                },
                                delete: (idItem, idUser) async {
                                  await DetailCartModal.deleteItem(idItem, idUser);
                                  cartCubit.deleteItemCart(item: item, idItem: idItem, idUser: idUser);
                                },
                                onTotalUpdated: (idSeller, totalSeller, numbers) {
                                  cartCubit.onTotalUpdated(idSeller: idSeller, totalSeller: totalSeller, numbers: numbers);
                                },
                              )

                        ],
                      )
                  ),
                  const SizedBox(width: 20,) ,
                  if(cartCubit.state.isDone) getWidget(constraints , cartCubit.state) ,
                ],
              )),
      )
    );
  }
}
