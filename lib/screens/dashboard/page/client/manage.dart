import 'package:exchange_book/screens/dashboard/page/client/card_detail.dart';
import 'package:exchange_book/screens/dashboard/page/client/cubit/manage/manage_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage/widget_list_book.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage/widget_sign_up_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/ConstraintData.dart';
import '../../../../model/book_modal.dart';
import '../../../../model/user_modal.dart';

class Manage extends StatefulWidget {
  final UserModel user ;
  const Manage({super.key , required this.user});

  @override
  State<Manage> createState() => _ManageState();
}

class _ManageState extends State<Manage> {

  Widget getWidget(ManageState state) {
    if(state.page == 0) {
      return WidgetListBook(
        user: widget.user,
        handle: (data) {},
      );
    }
    else {
      return WidgetSignUpBook(
        user: widget.user,
        insert: (bookModal) {
          BookModal.updateDatabaseBook(
            bookModal,
            "$location/insertBook",
                () {toast("Thêm thành công");},
                () {toast("Thêm không thành công");},
          );
        },
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageCubit, ManageState>(builder: (context, state) {
      return Scaffold(
        body: SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(20), child: getWidget(context.read<ManageCubit>().state),),),
        floatingActionButton: FloatingActionButton(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
          child: Icon(state.page == 0 ? Icons.add : Icons.rotate_left , size: 25,),
          onPressed: () {
            if(state.page == 1 || state.page == 2) {
              context.read<ManageCubit>().exchangePage(page: 0);
            }
            else if(state.page == 0) {
              context.read<ManageCubit>().exchangePage(page: 1);
            }
          },
        ),
      );
    },);
  }
}
