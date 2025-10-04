
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../model/user_modal.dart';


part 'manage_point_state.dart';
part 'manage_point_cubit.freezed.dart';

class ManagePointCubit extends Cubit<ManagePointState> {
  ManagePointCubit() : super(const ManagePointState.initial());

  void loading(String idUser) async {
    emit(const ManagePointState.loading());
    List<dynamic> data = await UserModel.loadDataUser(idUser) ;

    final newsListId = data.map((entry) {
      return int.tryParse(entry[0].toString()) ?? -1;
    }).where((id) => id != -1).toList();

    emit(ManagePointState.loaded(list: data , listId: newsListId , pointTotal: 0));
  }

  void exchangeListId(String address) {
    state.whenOrNull(
      loaded: (list, listId, pointTotal) {
        if (address.trim().isEmpty) {

          final newsListId = list.map((entry) {
            return int.tryParse(entry[0].toString()) ?? -1;
          }).where((id) => id != -1).toList();

          emit(ManagePointState.loaded(list: list,listId: newsListId,pointTotal: pointTotal,));
        } else {
          // Lọc danh sách theo địa chỉ
          final filtered = list.where((entry) {
            final addressOfUser =
            (entry.length > 9 ? entry[9]?.toString() ?? '' : '').toLowerCase();
            final addressSearch = address.trim().toLowerCase();
            return entry.isEmpty || addressOfUser.contains(addressSearch);
          }).toList();

          // Lấy listId từ cột đầu tiên (entry[0]) và convert sang int
          final newsListId = filtered.map((entry) {
            return int.tryParse(entry[0].toString()) ?? -1;
          }).where((id) => id != -1).toList();

          emit(ManagePointState.loaded(
            list: list,
            listId: newsListId,
            pointTotal: pointTotal,
          ));
        }
      },
    );
  }


  void exchangeListPoint(String newsListPointText)  {
    state.whenOrNull(
      loaded: (list, listId ,pointTotal) {
        if (newsListPointText.trim() == "") {
          emit(ManagePointState.loaded(list: list, listId: listId, pointTotal: 0));
        }
        else {
          emit(ManagePointState.loaded(list: list, listId: listId , pointTotal: int.parse(newsListPointText)));
        }
      },
    );
  }

}
