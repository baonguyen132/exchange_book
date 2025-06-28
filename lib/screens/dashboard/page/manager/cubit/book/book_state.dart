part of 'book_cubit.dart';

@freezed
class BookState with _$BookState{
  const factory BookState.initial(
      {
        required List<TypeBookModal> list ,
        required bool frame
      }) = _Initial;
}
