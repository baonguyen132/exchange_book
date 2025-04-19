import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_admin/model/TypeBookModal.dart';
import 'package:project_admin/screens/dashboard/page/widget/book/widget_form_insert_product.dart';
import 'package:project_admin/screens/dashboard/page/widget/book/widget_list_product.dart';

import '../../../data/ConstraintData.dart';

class Book extends StatefulWidget {

  Book({super.key});

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  List<TypeBookModal> list = [] ;
  bool frame = true ;

  void loadData() async {
    final result = await TypeBookModal.exportTypeBook(() {},) ;
    setState(() {
      list = result ;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData() ;

  }

  Widget getFrame() {
    if(frame) {
      return WidgetListProduct(
        list: list,
        update: (typeBookModal) {
          TypeBookModal.updateDatabaseTypeBook(
            typeBookModal,
            location+"/updateTypeBook" ,
            () {
              setState(() {
                for(int i = 0 ; i < list.length ; i++) {
                  if(list[i].id == typeBookModal.id) {
                    list[i] = typeBookModal ;
                  }
                }
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
                msg: "Cập nhật bị lỗi",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black54,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            },

          );

        },
        delete: (typeBookModal) {
          TypeBookModal.updateDatabaseTypeBook(
            typeBookModal,
            location+"/deleteTypeBook" ,
            () {
              setState(() {
                for(int i = 0 ; i < list.length ; i++) {
                  if(list[i].id == typeBookModal.id) {
                    list.removeAt(i) ;
                  }
                }
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
      );
    }
    else {
      return WidgetFormInsertProduct(
        insert: (typeBookModal) {

          TypeBookModal.updateDatabaseTypeBook(
            typeBookModal,
            "$location/insertTypeBook",
            () {
              setState(() {
                list.add(typeBookModal) ;
              });
              Fluttertoast.showToast(
                msg: "Thêm thành công",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black54,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            },
            () {
              Fluttertoast.showToast(
                msg: "Thêm không thành công",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black54,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            },
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: getFrame(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            frame = !frame ;
          });
        },
        child: Icon(frame ? Icons.add : Icons.arrow_back),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100),),
      ),
    );
  }
}