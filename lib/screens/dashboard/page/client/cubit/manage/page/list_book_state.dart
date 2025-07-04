part of 'list_book_cubit.dart';

@freezed
class ListBookState with _$ListBookState{
  const factory ListBookState.initial({
    required List<dynamic> list ,
    required bool isLoading ,
    required int current ,
  }) = _Initial;
}
