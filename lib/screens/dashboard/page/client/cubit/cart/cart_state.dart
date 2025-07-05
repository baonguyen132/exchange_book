part of 'cart_cubit.dart';

@freezed
class CartState with _$CartState{
  const factory CartState.initial({
    required Map<String , String>? listSeller ,

    required Map<String, int> total ,

    required String address ,
    required int totalSeller ,
    required String totalText ,
    required bool isDone ,
  }) = _Initial;
}
