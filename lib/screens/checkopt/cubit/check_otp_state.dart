part of 'check_otp_cubit.dart';

@freezed
class CheckOtpState with _$CheckOtpState{
  const factory CheckOtpState.initial(
      {
        required int number,
        required String email
      }
      ) = _Initial;
}
