part of 'manage_user_cubit.dart';

@freezed
class ManageUserState with _$ManageUserState{
  const factory ManageUserState.initial(
      {
        required List<dynamic> list
      }
      ) = _Initial;
}
