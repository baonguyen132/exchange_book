import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../model/CartModal.dart';

part 'list_item_state.dart';
part 'list_item_cubit.freezed.dart';

class ListItemCubit extends Cubit<ListItemState> {
  ListItemCubit() : super(const ListItemState.initial(
      listItem: [],
      stateClick: false,
      stateItem: ""
  ));

  void loadData(String id , String stateItem) async {
    List<dynamic> data = await CartModal.exportItemCart(id);
    emit(state.copyWith(listItem: data , stateItem: stateItem));

  }

  void exchangeState(String stateItem) {
    emit(state.copyWith(stateClick: !state.stateClick , stateItem: stateItem));
  }



}
