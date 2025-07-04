part of 'sign_up_book_cubit.dart';

@freezed
class SignUpBookState with _$SignUpBookState{
  const factory SignUpBookState.initial({
    required TypeBookModal? typeBookModal  ,
    required String error  ,

    required String path ,
    required String datePurchase,
    required String price ,
    required String description,
    required String quantity
  }) = _Initial;
}
