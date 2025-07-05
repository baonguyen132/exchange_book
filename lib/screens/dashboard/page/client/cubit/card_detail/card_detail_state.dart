part of 'card_detail_cubit.dart';

@freezed
class CardDetailState with _$CardDetailState{
  const factory CardDetailState.initial({
    required UserModel? user ,
    required String pathAva ,
  }) = _Initial;
}
