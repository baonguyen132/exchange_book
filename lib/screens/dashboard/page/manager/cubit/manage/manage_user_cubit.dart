
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../model/user_modal.dart';

part 'manage_user_state.dart';
part 'manage_user_cubit.freezed.dart';

class ManageUserCubit extends Cubit<ManageUserState> {
  ManageUserCubit() : super(const ManageUserState.initial());

  void loading() async {
    emit(const ManageUserState.loading());
    List<dynamic> data = await UserModel.loadDataUserFromServe(0 , 1) ;
    emit(ManageUserState.loaded(page: 1, list: data));
  }

  void change(String status , int currentPage) async {
    emit(const ManageUserState.loading());
    if(status == "+") {currentPage++ ;}
    else {currentPage-- ;}
    List<dynamic> data = await UserModel.loadDataUserFromServe(0, currentPage) ;
    emit(ManageUserState.loaded(page: currentPage, list: data));
  }


}