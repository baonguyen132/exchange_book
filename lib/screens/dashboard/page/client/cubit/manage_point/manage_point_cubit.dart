
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../model/user_modal.dart';


part 'manage_point_state.dart';
part 'manage_point_cubit.freezed.dart';

class ManagePointCubit extends Cubit<ManagePointState> {
  ManagePointCubit() : super(const ManagePointState.initial());

  void loading() async {
    emit(const ManagePointState.loading());
    List<dynamic> data = await UserModel.loadDataUser() ;
    emit(ManagePointState.loaded(list: data , listId: [] , listPoint: []));
  }

  void exchangeListId(String newsListIdText)  {
    state.whenOrNull(
      loaded: (list, listId ,listPoint) {
        if (newsListIdText.trim() == "") {
          emit(ManagePointState.loaded(list: list, listId: [], listPoint: listPoint));
        }
        else {
          // Chuyển listId thành danh sách số nguyên
          List<int> newsListId = newsListIdText.split(' ').map((e) => int.tryParse(e) ?? -1).toList();
          emit(ManagePointState.loaded(list: list, listId: newsListId , listPoint: listPoint));
        }
      },
    );
  }

  void exchangeListPoint(String newsListPointText)  {
    state.whenOrNull(
      loaded: (list, listId ,listPoint) {
        if (newsListPointText.trim() == "") {
          emit(ManagePointState.loaded(list: list, listId: listId, listPoint: []));
        }
        else {
          // Chuyển listId thành danh sách số nguyên
          List<int> newsListPoint = newsListPointText.split(' ').map((e) => int.tryParse(e) ?? -1).toList();
          emit(ManagePointState.loaded(list: list, listId: listId , listPoint: newsListPoint));
        }
      },
    );
  }

}
