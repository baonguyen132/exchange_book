part of 'list_item_cubit.dart';

@freezed
class ListItemState with _$ListItemState{
  const factory ListItemState.initial({
    required List<dynamic> listItem ,
    required bool stateClick  ,
    required String stateItem
  }) = _Initial;
}
