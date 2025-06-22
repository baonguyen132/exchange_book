
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/ConstraintData.dart';

part 'sign_up_state.dart';
part 'sign_up_cubit.freezed.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState.initial(
    fullName: "",
    email: "" ,
    password: "",
    checkPassword: "",
    dob: "",
    numberId: "",
    address: "",

    gender: "Male",

    scanQRCode: true,

  ));

  void handleQRCode(String data) {
    List<String> arrayData = data.split("|") ;
    emit(state.copyWith(
      numberId:  arrayData[0],
      fullName: arrayData[2],
      dob:  formatIDToDate(arrayData[3]),
      gender: arrayData[4] == "Nam" ? "Male" : "Female",
      address:  arrayData[5],

      scanQRCode: false
    ));
  }

  void changeFullName(String value) {
    emit(state.copyWith(fullName: value));
  }

  void changeEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void changePassword(String value) {
    emit(state.copyWith(password: value));
  }

  void changeCheckPassword(String value) {
    emit(state.copyWith(checkPassword: value));
  }

  void changeDob(String value) {
    String formatted = formatIDToDate(value);
    emit(state.copyWith(dob: formatted));
  }

  void changeNumberId(String value) {
    emit(state.copyWith(numberId: value));
  }

  void changeAddress(String value) {
    emit(state.copyWith(address: value));
  }

  void changeGender(String value) {
    emit(state.copyWith(gender: value));
  }

  void toggleQRCodeScan(bool value) {
    emit(state.copyWith(scanQRCode: value));
  }

}