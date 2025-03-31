import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/widget/book/widget_form_insert_product.dart';
import 'package:project_admin/screens/dashboard/page/widget/book/widget_list_product.dart';

class Book extends StatefulWidget {
  const Book({super.key});

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {

  bool frame = true ;

  Widget getFrame() {
    if(frame) {
      return Container();
    }
    else {
      return WidgetFormInsertProduct();
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