part of 'dashboard_cubit.dart';

@freezed
class DashboardState with _$DashboardState{
  const factory DashboardState.initial(
      {
        required bool isLoading ,

        required int indexScreen,
        required int status,
        required Widget screen,
        required UserModel user,
      }
  ) = _Initial;
}
