part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState{
  const factory LoginState.initial(
      {
        required String email,
        required String password,

        required bool isSaveFinger ,

        required bool isVisibility

      }) = _Initial;
}
