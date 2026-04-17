part of 'manage_point_cubit.dart';

@freezed
class ManagePointState with _$ManagePointState{
  const factory ManagePointState.initial() = _Initial;
  const factory ManagePointState.loading() = _Loading ;
  const factory ManagePointState.loaded(
      {
        required int page ,
        required List<dynamic> list,
        required String address ,
        required int point ,


      }) = _Loaded ;
}
