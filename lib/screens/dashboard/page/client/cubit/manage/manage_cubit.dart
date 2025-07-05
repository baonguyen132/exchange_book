
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'manage_state.dart';
part 'manage_cubit.freezed.dart';

class ManageCubit extends Cubit<ManageState> {
  ManageCubit() : super(const ManageState.initial(
      page: 0,
      item: []
  ));

  void exchangePage({required int page , List<dynamic>? item}) {
    if(item != null ) {emit(state.copyWith(page: page, item: item));}
    else {emit(state.copyWith(page: page ));}
  }
}
