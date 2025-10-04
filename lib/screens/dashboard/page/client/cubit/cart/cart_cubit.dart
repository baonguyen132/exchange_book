
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../model/detail_cart_modal.dart';


part 'cart_state.dart';
part 'cart_cubit.freezed.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState.initial(
    listSeller: null ,
    total: {},

    address: "",
    totalSeller: 0,
    totalText: "",
    isDone: false ,
  ));

  void loadData() async {
    Map<String , String>? data = await DetailCartModal.loadData() ;
    emit(state.copyWith(listSeller: data , totalSeller: 0 , totalText: ""));
  }
  void is_Done() => emit(state.copyWith(isDone: true));

  void loadTotal() {
    String totalText = "" ;
    int totalSeller = 0 ;
    for (var item in state.total.entries) {
      totalText = "$totalText-${item.value}";
      totalSeller += item.value;
    }
    emit(state.copyWith(totalText: totalText , totalSeller: totalSeller));
  }

  void updateItemCart({required dynamic item, required String idItem, required String idUser, required int value,}) {
    final total = Map<String, int>.from(state.total); // clone để tránh lỗi mutation trực tiếp

    jsonDecode(item.value).forEach((key, itemValue) {
      DetailCartModal detail = DetailCartModal.fromJson(jsonDecode(itemValue));
      if(detail.bookModal.id == idItem){
        total[idUser] = (total[idUser]! - (detail.quantity - value) * int.parse(detail.bookModal.price))  ;
      }
    });
    emit(state.copyWith(total: total));
    loadData() ;
  }

  void deleteItemCart({required dynamic item, required String idItem, required String idUser,}) {
    final total = Map<String, int>.from(state.total);

    final decoded = jsonDecode(item.value);

    decoded.forEach((key, itemValue) {
      final detail = DetailCartModal.fromJson(jsonDecode(itemValue));

      if (detail.bookModal.id == idItem) {
        final price = int.tryParse(detail.bookModal.price) ?? 0;
        final quantity = detail.quantity;

        final oldTotal = total[idUser] ?? 0;
        final deduction = quantity * price;

        total[idUser] = oldTotal - deduction;
      }
    });

    emit(state.copyWith(total: total));
    loadData() ;

  }
  void onTotalUpdated({required String idSeller, required int totalSeller , required int numbers}) {
    final total = Map<String, int>.from(state.total);
    total[idSeller] = totalSeller ;
    if(numbers >= state.listSeller!.length) {emit(state.copyWith(total: total , isDone: true));}
    else {emit(state.copyWith(total: total));}
    loadTotal();

  }


}
