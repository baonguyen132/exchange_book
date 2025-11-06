
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../model/user_modal.dart';


part 'manage_point_state.dart';
part 'manage_point_cubit.freezed.dart';

class ManagePointCubit extends Cubit<ManagePointState> {
  ManagePointCubit() : super(const ManagePointState.initial());

  void loading(int idUser) async {
    emit(const ManagePointState.loading());
    List<dynamic> data = await UserModel.loadDataUserFromServe(idUser , 1) ;

    emit(ManagePointState.loaded(page:1 ,list: data, address: "", point: 0));
  }

  void exchangePoint(String newPoint)  {
    state.whenOrNull(
      loaded: (page, list, address, point) {
        if(newPoint != "") { emit(ManagePointState.loaded(page: page,list: list, address: address, point: int.parse(newPoint)));}
        else {emit(ManagePointState.loaded(page: page,list: list, address: address, point: 0));}
      },
    );
  }

  void exchangeAddress(String newAddress)  {
    state.whenOrNull(
      loaded: (page, list, address, point) {
        if(newAddress != "") { emit(ManagePointState.loaded(page: page,list: list, address: newAddress, point: point));}
        else {emit(ManagePointState.loaded(page: page,list: list, address: "", point: point));}
      },
    );
  }

  void searchUser(int id) {
    state.whenOrNull(loaded: (page, list, address, point) async {
      emit(const ManagePointState.loading());
      List<dynamic> data = await UserModel.loadDataUserAddressFromServe(id, page, address) ;
      emit(ManagePointState.loaded(page: page, list: data, address: address, point: point));

    },);
  }

  void change(String status , int idUser) async {
    state.whenOrNull(
      loaded: (page, list, address, point) async {
        emit(const ManagePointState.loading());
        int current = page ;
        if(status == "+") {current++ ;}
        else {current-- ;}

        List<dynamic> data = await UserModel.loadDataUserFromServe(idUser , current) ;

        emit(ManagePointState.loaded(page:current ,list: data, address: address , point: point));
      },
    );

  }

}
