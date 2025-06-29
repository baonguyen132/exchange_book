part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState{
  const factory ProfileState.initial(
      {
        required List<dynamic> list ,
        required UserModel user ,
      }) = _Initial;
}
