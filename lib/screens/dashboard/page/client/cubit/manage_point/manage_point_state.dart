part of 'manage_point_cubit.dart';

@freezed
class ManagePointState with _$ManagePointState{
  const factory ManagePointState.initial() = _Initial;
  const factory ManagePointState.loading() = _Loading ;
  const factory ManagePointState.loaded(
      {
        required List<dynamic> list,
        required List<int> listId ,
        required List<int> listPoint ,

      }) = _Loaded ;
}
