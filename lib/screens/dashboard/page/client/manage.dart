import 'package:exchange_book/screens/dashboard/page/client/widget/manage/widget_list_book.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage/widget_sign_up_book.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(20), child:
         WidgetListBook(
        user: widget.user,
        handle: (data) {},
      ),),),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
        child: const Icon( Icons.add  , size: 25,),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => WidgetSignUpBook(
              user: widget.user,
              insert: (bookModal) {
                BookModal.updateDatabaseBook(
                  bookModal,
                  "$location/insertBook",
                      () {toast("Thêm thành công");},
                      () {toast("Thêm không thành công");},
                );
              },),)
          );
        },
      ),
    );
  }
}
