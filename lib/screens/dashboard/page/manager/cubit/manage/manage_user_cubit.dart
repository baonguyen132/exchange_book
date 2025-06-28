
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../model/UserModal.dart';

part 'manage_user_state.dart';
part 'manage_user_cubit.freezed.dart';

class ManageUserCubit extends Cubit<ManageUserState> {
  ManageUserCubit() : super(const ManageUserState.initial(list: []));


  void loadData() async {
    List<dynamic> data = await UserModel.loadDataUser() ;
    emit(state.copyWith(list: data));
  }

}