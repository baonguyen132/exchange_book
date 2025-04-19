import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_admin/screens/dashboard/page/card_detail.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/detail/widget_button_card_detail_of_history.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/detail/widget_item_person_change.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/widget_list_book.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/widget_sign_up_book.dart';

import '../../../data/ConstraintData.dart';
import '../../../model/BookModal.dart';
import '../../../model/UserModal.dart';

class History extends StatefulWidget {
  UserModel user ;
  History({super.key , required this.user});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  List<dynamic>? list ;
  int state = 0 ;
  List<dynamic>? item ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData(1) ;
  }

  void loadData(int choose) async {
    List<dynamic> data ;
    if(choose == 1) {
      data = await BookModal.exporUserBook(widget.user.id.toString(), () {

      },);
    }
    else {
      data = [] ;
    }
    setState(() {
      list = data ;
    });
  }

  Widget getWidget() {
    if(state == 0) {

      return list != null ? WidgetListBook(
        list: list!,
        handle: (data) {
          setState(() {
            state = 2 ;
            item = data ;
          });
        },
        handleChoose: (choose) {
          setState(() {
            loadData(choose) ;
          });
        },
      ): Container();
    }
    else if(state == 1) {
      return WidgetSignUpBook(
        user: widget.user,
        insert: (bookmodal) {
          BookModal.updateDatabaseBook(
            bookmodal,
            "$location/insertBook",
                () {

                },
                () {

                },
          );
        },
      );
    }
    else if(state == 2) {
      return CardDetail(
        item: item!,
        wigetHasListButton: WidgetButtonCardDetailOfHistory(
            item: item!,
            editItem: (bookModal) {
              BookModal.updateDatabaseBook(bookModal, "$location/updateBook",
                    () {
                  setState(() {
                    state = 0;
                    loadData(1);
                  });
                  Fluttertoast.showToast(
                    msg: "Cập nhật thành công",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
                    () {
                  Fluttertoast.showToast(
                    msg: "Cập nhật không thành công",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
              );
            },
          deleteItem: (bookModal) {
            BookModal.updateDatabaseBook(bookModal, "$location/deleteBook",
                  () {
                setState(() {
                  state = 0;
                  loadData(1);
                });
                Fluttertoast.showToast(
                  msg: "Xoá thành công",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
                  () {
                Fluttertoast.showToast(
                  msg: "Không thể xoá được",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
            );
          },
        ),
        titleRight: "Danh sách người muốn đổi",
        list: LayoutBuilder(builder: (context, constraints) => Column(
          children: [
            for(int i = 0 ; i < 5 ; i++)
              WidgetItemPersonChange(
                width: constraints.maxWidth,
                change: () {

                },
                nochange: () {

                },
              ),
          ],
        ),)
      ) ;
    }
    else {
      return Container();
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Padding(padding: EdgeInsets.all(20), child: getWidget(),),),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
        child: Icon(state == 0 ? Icons.add : Icons.rotate_left , size: 25,),
        onPressed: () {
          setState(() {
            if(state == 1 || state == 2) {
              state = 0 ;
            }
            else if(state == 0) {
              state = 1 ;
            }

          });
        },
      ),
    );
  }
}
