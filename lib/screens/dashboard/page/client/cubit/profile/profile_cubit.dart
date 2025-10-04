
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../../model/book_modal.dart';
import '../../../../../../model/user_modal.dart';



part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.initial(
      list: [],
      user: UserModel(id: '', name: '', email: '', password: '', cccd: '', dob: '', gender: '', address: '',point: '' ,token: '')
  ));

  void loadingData() async {
    UserModel? dataUser = await UserModel.loadUserData();
    List<dynamic> dataBooks = await BookModal.exporUserBook(dataUser!.id.toString());

    emit(state.copyWith(list: dataBooks , user: dataUser));

  }
}
