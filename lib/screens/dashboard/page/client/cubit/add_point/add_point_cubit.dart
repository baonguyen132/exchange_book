import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../model/user_modal.dart';

part 'add_point_state.dart';
part 'add_point_cubit.freezed.dart';

class AddPointCubit extends Cubit<AddPointState> {
  AddPointCubit(UserModel userModel)
      : super(AddPointState.initial(
            path: "",
            idPurchasePoint: "",
            amout: 0,
            errorAmout: "",
            user: userModel));

  int generate8DigitNumber() {
    final random = Random();
    // 10 chữ số từ 1000000000 đến 9999999999
    return 10000000 + random.nextInt(90000000);
  }

  void loading() async {
    String? newPath = await UserModel.exportImageAva(state.user.id.toString());
    if (newPath.isNotEmpty && state.path != newPath) {
      newPath = newPath.replaceAll("\\", "/"); // Chuẩn hóa đường dẫn
      emit(state.copyWith(
          path: newPath,
          idPurchasePoint: state.user.cccd + generate8DigitNumber().toString(),
          amout: 0));
    }
    String id = generate8DigitNumber().toString();
    emit(state.copyWith(idPurchasePoint: id, amout: 0));
  }

  void exchangePoint(int value) {
    if (value < 20000) {
      emit(state.copyWith(
          amout: value, errorAmout: "Giá trị phải hơn hoặc bằng 10.000"));
    } else {
      emit(state.copyWith(amout: value, errorAmout: ""));
    }
  }


}
