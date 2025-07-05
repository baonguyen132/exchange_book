part of 'manage_cubit.dart';

@freezed
class ManageState with _$ManageState{
  const factory ManageState.initial({
    required int page,
    required List<dynamic>? item
  }) = _Initial;
}
