
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../model/user_modal.dart';


part 'card_detail_state.dart';
part 'card_detail_cubit.freezed.dart';

class CardDetailCubit extends Cubit<CardDetailState> {
  CardDetailCubit() : super(const CardDetailState.initial(
      user: null,
      pathAva: ""
  ));

  void loadData(String id) async {
    UserModel? data = await UserModel.exportUser(id) ;
    String pathData = await UserModel.exportImageAva(id) ;
    if(pathData != ""){
      pathData = pathData.replaceAll("\\", "/") ;
      emit(state.copyWith(user: data , pathAva: pathData));
    }
    else {
      emit(state.copyWith(user: data));
    }
  }

}
