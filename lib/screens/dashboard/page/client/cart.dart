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
  final Function(Map<String, String> data, String address, String totalText,
      int totalSeller, String path) handleInsert;
  final UserModel userModel;
  const Cart({super.key, required this.handleInsert, required this.userModel});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late CartCubit cartCubit;
  late TextEditingController address;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartCubit = CartCubit();
    address = TextEditingController(text: cartCubit.state.address);
    cartCubit.loadData();
    cartCubit.loadTotal();
  }

  Widget getWidget(constraints, CartState state) {
    String _fmt(int v) => v
        .toString()
        .replaceAllMapped(RegExp(r"\B(?=(\d{3})+(?!\d))"), (m) => ',');

    final total = state.totalSeller;

    return Container(
      width: constraints.maxWidth < 500
          ? constraints.maxWidth
          : constraints.maxWidth * 0.3,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surface,
        border:
            Border.all(color: Theme.of(context).dividerColor.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Thông tin người mua",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Text('Tên: ${widget.userModel.name}',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 4),
          Text('Email: ${widget.userModel.email}',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.black54)),
          const SizedBox(height: 12),
          Divider(color: Theme.of(context).dividerColor),
          const SizedBox(height: 12),
          Text('Tổng tiền',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(_fmt(total) + ' VND',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.green[700], fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          WidgetTextFieldCustom(
            controller: address,
            textInputType: TextInputType.text,
            hint: "Nhập địa chỉ nhận",
            iconData: CupertinoIcons.location,
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.handleInsert(
                    state.listSeller!,
                    address.text,
                    state.totalText,
                    state.totalSeller,
                    "$location/insert_cart");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              child: Text('Gửi',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int number = 1;
    return BlocBuilder<CartCubit, CartState>(
        bloc: cartCubit,
        builder: (context, state) => LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    children: [
                      SizedBox(
                          width: constraints.maxWidth < 500
                              ? constraints.maxWidth
                              : constraints.maxWidth * 0.7 - 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  "Danh sách sản phẩm",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .maintext),
                                ),
                              ),
                              if (state.listSeller != null)
                                for (var item in state.listSeller!.entries)
                                  CartItemSeller(
                                    idSeller: item.key,
                                    exportListRaw: jsonDecode(item.value),
                                    number: number++,
                                    update: (idItem, idUser, value) async {
                                      await DetailCartModal.updateItem(
                                        idItem,
                                        idUser,
                                        value,
                                      );
                                      cartCubit.updateItemCart(
                                          item: item,
                                          idItem: idItem,
                                          idUser: idUser,
                                          value: value);
                                    },
                                    delete: (idItem, idUser) async {
                                      await DetailCartModal.deleteItem(
                                          idItem, idUser);
                                      cartCubit.deleteItemCart(
                                          item: item,
                                          idItem: idItem,
                                          idUser: idUser);
                                    },
                                    onTotalUpdated:
                                        (idSeller, totalSeller, numbers) {
                                      cartCubit.onTotalUpdated(
                                          idSeller: idSeller,
                                          totalSeller: totalSeller,
                                          numbers: numbers);
                                    },
                                  )
                            ],
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      if (cartCubit.state.isDone)
                        getWidget(constraints, cartCubit.state),
                    ],
                  )),
            ));
  }
}
