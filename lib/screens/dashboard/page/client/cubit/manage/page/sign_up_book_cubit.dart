
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../data/ConstraintData.dart';
import '../../../../../../../model/book_modal.dart';
import '../../../../../../../model/type_book_modal.dart';


part 'sign_up_book_state.dart';
part 'sign_up_book_cubit.freezed.dart';

class SignUpBookCubit extends Cubit<SignUpBookState> {
  SignUpBookCubit() : super(const SignUpBookState.initial(
    typeBookModal: null,
    error: "",

    path: "",
    price: "",
    description: "",
    datePurchase: "",
    quantity: ""
  ));

  void pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    File? image;
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null)  {
      image = File(pickedFile.path);
      String name_book = await BookModal.scanImage(image) ;
      var  jsonResponse = (await BookModal.uploadImageAndExportTypeBook(image, name_book))! ;

      var data = jsonResponse["data"];

      TypeBookModal typeBookModal = TypeBookModal(
          id: data[0].toString(),
          name_book: data[1],
          type_book: data[2],
          price: data[3].toString(),
          description: data[5],
          image: data[4]
      ) ;
      emit(state.copyWith(typeBookModal: typeBookModal , path: jsonResponse["path"]));

    }
  }
  void changeDob(String value) {
    String formatted = formatIDToDate(value);
    emit(state.copyWith(datePurchase: formatted));
  }

  void changeError(String value) {
    emit(state.copyWith(error: value));
  }
  void changePrice(String value) {
    emit(state.copyWith(price: value));
  }

  void changeDescription(String value) {
    emit(state.copyWith(description: value));
  }

  void changeQuantity(String value) {
    emit(state.copyWith(quantity: value));
  }

  void reset() {
    emit(const SignUpBookState.initial(
      typeBookModal: null,
      error: "",
      path: "",
      price: "",
      description: "",
      datePurchase: "",
      quantity: "",
    ));
  }





}
