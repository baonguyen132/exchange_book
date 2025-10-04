part of 'manage_user_cubit.dart';

@freezed
class ManageUserState with _$ManageUserState{
  const factory ManageUserState.initial() = _Initial;
  const factory ManageUserState.loading() = _Loading ;
  const factory ManageUserState.loaded(
      {
        required List<dynamic> list
      }) = _Loaded ;
}
