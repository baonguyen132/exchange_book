
import 'package:exchange_book/model/UserModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../model/MenuModal.dart';
import '../page/client/home.dart';
import '../page/client/manage.dart';
import '../page/client/product.dart';
import '../page/client/profile.dart';
import '../page/manager/book.dart';
import '../page/manager/home_admin.dart';
import '../page/manager/manage_user.dart';

part 'dashboard_state.dart';
part 'dashboard_cubit.freezed.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState.initial(
      isLoading: false,
      status: 0,
      indexScreen: 1,
      screen: const Home(),
      user: UserModel(
          id: "0",
          name: "",
          email: "",
          password: "",
          cccd: "",
          dob: "",
          gender: "",
          address: "",
          point: ""
      )
  ));

  void loadingDataUser() async {
    emit(state.copyWith(isLoading: true));
    UserModel? data = await UserModel.loadUserData() ;
    await Future.delayed(const Duration(seconds: 2));

    if (data == null) {emit(state.copyWith(isLoading: false));}
    else { emit(state.copyWith(isLoading: false , user: data)); }
  }

  void exchange(MenuModal item, bool isMobile) {
    Widget newScreen = Container();
    int newIndexScreen = 0 ;
    int newIndexStatus = 0 ;

    if(item.title == "Admin") {newIndexStatus = 1 ; newIndexScreen = item.id + 1;}
    else if(item.title == "Client") {newIndexStatus = 0 ; newIndexScreen = 1 ;}
    else {newIndexScreen = item.id ; newIndexStatus = state.status ;}


    if(newIndexScreen == 1){newScreen = const Home();}
    else if(newIndexScreen == 2) {newScreen = Product(userdata: state.user!,) ;}
    else if(newIndexScreen ==3){newScreen = Manage(user: state.user!,);}
    else if (newIndexScreen == 4) {newScreen = const Profile() ;}
    else if(newIndexScreen == 6) {newScreen = HomeAdmin(isMobile: isMobile,user: state.user!,);}
    else if(newIndexScreen == 7) {newScreen = Book();}
    else if(newIndexScreen == 8) {newScreen = const ManageUser();}


    emit(state.copyWith(indexScreen: newIndexScreen, status: newIndexStatus, screen: newScreen));
  }
}
