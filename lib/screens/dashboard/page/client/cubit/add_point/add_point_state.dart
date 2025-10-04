part of 'add_point_cubit.dart';

@freezed
class AddPointState with _$AddPointState{
  const factory AddPointState.initial(
      {
        required String idPurchasePoint ,
        required int amout,
        required String errorAmout ,
        required String path,
        required UserModel user
      }) = _Initial ;
}
