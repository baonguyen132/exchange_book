import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../model/UserModal.dart';

part 'check_otp_state.dart';
part 'check_otp_cubit.freezed.dart';

class CheckOtpCubit extends Cubit<CheckOtpState> {
  CheckOtpCubit(int number, String email) : super(CheckOtpState.initial(
      number: number,
      email: email,
      listDigital: ["","","","","",""]
  ));

  void generateRandomNumber() {
    Random random = Random();
    int newNumber = 100000 + random.nextInt(900000);
    UserModel.sendCodeOtp(state.email, newNumber) ;
    emit(state.copyWith(number: newNumber));
  }

  void exchangeListDigital(String value, int index) {
    final updatedList = List<String>.from(state.listDigital); // copy mới
    updatedList[index] = value;
    print(updatedList);
    emit(state.copyWith(listDigital: updatedList));
  }

}
