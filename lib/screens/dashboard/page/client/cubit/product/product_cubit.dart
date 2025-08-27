
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../model/book_modal.dart';


part 'product_state.dart';
part 'product_cubit.freezed.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductState.initial(
      isLoading: true ,
      listProduct: [],
      listProductBest: [],

      page: "list",
      detailProduct: [])
  );

  void loadData(String id) async {

    emit(state.copyWith(isLoading: true));

    List<dynamic> data = await BookModal.exportBook(id) ;

    emit(state.copyWith(listProduct: data , listProductBest:  data , isLoading: false));

  }

  void openDetailProduct(List<dynamic> detailProduct) {
    emit(state.copyWith(page: "detail" , detailProduct: detailProduct));
  }

  void handleFloatingButton() {
    if(state.page != "list" ) {emit(state.copyWith(page: "list"));}
    else  {emit(state.copyWith(page: "cart"));}
  }

  void back() {
    emit(state.copyWith(page: "list"));
  }

  Future<void> pickImage(ImageSource source, String id) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null)  {
      File image = File(pickedFile.path);
      List<dynamic> data = (await BookModal.uploadImageScan(image,"/scan_books", id))! ;
      emit(state.copyWith(listProductBest: data , listProduct: data));
    }
  }
}
