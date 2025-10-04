import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../model/book_modal.dart';
import '../../../../../../../model/cart_modal.dart';


part 'list_book_state.dart';
part 'list_book_cubit.freezed.dart';

class ListBookCubit extends Cubit<ListBookState> {
  ListBookCubit() : super(const ListBookState.initial(
      list: [],
      isLoading: false,
      current: 1
  ));

  void loadData(int page , String id) async {
    emit(state.copyWith(isLoading: true)) ;
    List<dynamic> data ;
    if(page == 1) {
      data = await BookModal.exporUserBook(id);
    }
    else if(page == 2) {
      data = await CartModal.exportCartPurchase(id);
    }
    else {
      data = await CartModal.exportCartSeller(id);
    }
    emit(state.copyWith(current: page , list: data , isLoading: false));
  }



}
