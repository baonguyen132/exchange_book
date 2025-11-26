import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../model/type_book_modal.dart';

part 'book_state.dart';
part 'book_cubit.freezed.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(const BookState.initial(
    list: [],
    frame: true,
    currentPage: 1 ,
  ));

  void loadData() async {
    final result = await TypeBookModal.exportTypeBook(() {},state.currentPage) ;
    emit(state.copyWith(list: result)) ;
  }

  void changeScreen() => emit(state.copyWith(frame: !state.frame)) ;

  void updateTypeBook(TypeBookModal typeBookModal) {
    final newList = List<TypeBookModal>.from(state.list); // tạo bản sao mới

    for (int i = 0; i < newList.length; i++) {
      if (newList[i].id == typeBookModal.id) {
        newList[i] = typeBookModal;
        emit(state.copyWith(list: newList));
        break;
      }
    }
  }

  void deleteTypeBook(TypeBookModal typeBookModal) {
    final newList = List<TypeBookModal>.from(state.list);
    newList.removeWhere((item) => item.id == typeBookModal.id);
    emit(state.copyWith(list: newList));
  }

  void addTypeBook(TypeBookModal typeBookModal) {
    final newList = List<TypeBookModal>.from(state.list); // tạo bản sao
    newList.add(typeBookModal);
    emit(state.copyWith(list: newList));
  }

  void change(String status) async {
    int currentPage = state.currentPage ;
    if(status == "+") {currentPage++ ;}
    else {currentPage-- ;}

    final result = await TypeBookModal.exportTypeBook(() {},currentPage) ;
    emit(state.copyWith(list: result, currentPage: currentPage)) ;
  }

  // void searchBook(String query) {
  //   final list = List<TypeBookModal>.from(state.list);
  //
  //
  // }

}