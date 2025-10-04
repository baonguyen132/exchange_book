
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../model/user_modal.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState.initial(
    email: "",
    password: "",

    isSaveFinger: false,

    isVisibility: false

  ));

  void loadingUsername() async {
    String? email =  await UserModel.loadUserName();
    if(email != "") emit(state.copyWith(email: email));
  }

  void changeIsSaveFinger (){
    emit(state.copyWith(isSaveFinger: !state.isSaveFinger));
  }

  void changeEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void changePassword(String value) {
    emit(state.copyWith(password: value));
  }
  void changeIsVisibility() {
    emit(state.copyWith(isVisibility: !state.isVisibility));
  }

}