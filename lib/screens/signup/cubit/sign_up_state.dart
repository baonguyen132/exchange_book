part of 'sign_up_cubit.dart';

@freezed
class SignUpState with _$SignUpState{
  const factory SignUpState.initial(
  {
    required String email,
    required String fullName,
    required String password,
    required String checkPassword,
    required String dob,
    required String numberId,
    required String address,

    required String gender ,

    required bool scanQRCode

  }) = _Initial;
}
