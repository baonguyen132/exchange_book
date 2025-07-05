part of 'product_cubit.dart';

@freezed
class ProductState with _$ProductState{
  const factory ProductState.initial(
      {
        required bool isLoading ,

        required List<dynamic> listProductBest ,
        required List<dynamic> listProduct ,
        required String page,

        required List<dynamic> detailProduct ,

      }) = _Initial;
}
