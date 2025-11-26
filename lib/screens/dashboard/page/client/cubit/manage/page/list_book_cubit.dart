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
      current: 1,

      currentPage: 1
  ));

  void loadData(int page, int id, int currentPage) async {
    emit(state.copyWith(isLoading: true)) ;
    List<dynamic> data ;
    if(page == 1) {
      data = await BookModal.exportUserBook(id, currentPage);
    }
    else if(page == 2) {
      data = await CartModal.exportCartPurchase(id, currentPage);
    }
    else {
      data = await CartModal.exportCartSeller(id, currentPage);
    }
    emit(state.copyWith(current: page , list: data , isLoading: false , currentPage: currentPage));
  }

  void change(String status, int page, int id) async {
    int currentPage = state.currentPage ;
    if(status == "+") {currentPage++ ;}
    else {currentPage-- ;}

    loadData(page, id, currentPage);

  }


}
