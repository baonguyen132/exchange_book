import 'package:flutter/material.dart';
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
    final result = await TypeBookModal.exportBook(() {},) ;
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
                () {},
          );
          setState(() {
            for(int i = 0 ; i < list.length ; i++) {
              if(list[i].id == typeBookModal.id) {
                list[i] = typeBookModal ;
              }
            }
          });
        },
        delete: (typeBookModal) {
          TypeBookModal.updateDatabaseTypeBook(
            typeBookModal,
            location+"/deleteTypeBook" ,
                () {},
          );
          setState(() {
            for(int i = 0 ; i < list.length ; i++) {
              if(list[i].id == typeBookModal.id) {
                list.removeAt(i) ;
              }
            }
          });
        },
      );
    }
    else {
      return WidgetFormInsertProduct(
        insert: (typeBookModal) {
          list.add(typeBookModal) ;
          TypeBookModal.updateDatabaseTypeBook(
            typeBookModal,
            "$location/insertTypeBook",
                () {

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