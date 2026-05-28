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
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    String _fmt(int v) => v
        .toString()
        .replaceAllMapped(RegExp(r"\B(?=(\d{3})+(?!\d))"), (m) => ',');

    final total = state.totalSeller;

    return Container(
      width: constraints.maxWidth < 500
          ? constraints.maxWidth
          : constraints.maxWidth * 0.3,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDark ? cs.surface : Colors.white,
        border: Border.all(color: cs.onSurface.withOpacity(0.06)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: cs.primary.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.person_outline_rounded, color: cs.primary, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  "Thông tin người mua",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // User info
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: cs.onSurface.withOpacity(0.03),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.badge_outlined, size: 16, color: cs.onSurface.withOpacity(0.5)),
                    const SizedBox(width: 8),
                    Text(widget.userModel.name,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.email_outlined, size: 16, color: cs.onSurface.withOpacity(0.5)),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(widget.userModel.email,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurface.withOpacity(0.6))),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Divider(color: cs.onSurface.withOpacity(0.06)),
          const SizedBox(height: 16),

          // Total
          Row(
            children: [
              Text('Tổng tiền',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600, color: cs.onSurface.withOpacity(0.7))),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('${_fmt(total)} VND',
                    style: TextStyle(
                        color: Colors.green[700], fontWeight: FontWeight.w800, fontSize: 16)),
              ),
            ],
          ),
          const SizedBox(height: 18),

          WidgetTextFieldCustom(
            controller: address,
            textInputType: TextInputType.text,
            hint: "Nhập địa chỉ nhận",
            iconData: CupertinoIcons.location,
          ),
          const SizedBox(height: 20),

          // Submit button
          SizedBox(
            width: double.infinity,
            height: 50,
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
                backgroundColor: cs.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.send_rounded, size: 18, color: Colors.white),
                  const SizedBox(width: 10),
                  Text('Gửi đơn hàng',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    int number = 1;

    return BlocBuilder<CartCubit, CartState>(
        bloc: cartCubit,
        builder: (context, state) => LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Wrap(
                    children: [
                      SizedBox(
                          width: constraints.maxWidth < 500
                              ? constraints.maxWidth
                              : constraints.maxWidth * 0.7 - 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      cs.primary.withOpacity(0.10),
                                      cs.primary.withOpacity(0.03),
                                      isDark ? cs.surface : Colors.white,
                                    ],
                                    stops: const [0.0, 0.4, 1.0],
                                  ),
                                  border: Border.all(color: cs.primary.withOpacity(0.08)),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: cs.primary.withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(Icons.shopping_bag_rounded, color: cs.primary, size: 22),
                                    ),
                                    const SizedBox(width: 14),
                                    Text(
                                      "Giỏ hàng",
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -0.3),
                                    ),
                                  ],
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
                      const SizedBox(width: 20),
                      if (cartCubit.state.isDone)
                        getWidget(constraints, cartCubit.state),
                    ],
                  )),
            ));
  }
}
