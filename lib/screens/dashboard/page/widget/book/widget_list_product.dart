import 'package:flutter/material.dart';
import 'package:project_admin/data/ConstraintData.dart';
import 'package:project_admin/screens/dashboard/page/widget/book/card_type_book.dart';

import '../../../../../model/TypeBookModal.dart';
import '../../../../../util/widget_textfield_area.dart';
import '../../../../../util/wiget_textfield_custome.dart';


class WidgetListProduct extends StatefulWidget {
  List<TypeBookModal> list ;
  WidgetListProduct({super.key , required this.list});

  @override
  State<WidgetListProduct> createState() => _WidgetListProductState();
}

class _WidgetListProductState extends State<WidgetListProduct> {
  void showEditProductDialog(
      BuildContext context,
      TypeBookModal typeBookModal,
      Function(TypeBookModal typeBookModal) onSubmit,
      ) {
    final TextEditingController nameBookController =
    TextEditingController(text: typeBookModal.name_book);
    final TextEditingController typeBookController =
    TextEditingController(text: typeBookModal.type_book);
    final TextEditingController descriptionController =
    TextEditingController(text: typeBookModal.description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.edit, color: Theme.of(context).primaryColor),
              SizedBox(width: 8),
              Text("Chỉnh sửa thông tin sách"),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WigetTextfieldCustome(
                  controller: nameBookController,
                  textInputType: TextInputType.text,
                  hint: "Nhập tên sách",
                  iconData: Icons.drive_file_rename_outline,
                ),
                SizedBox(height: 16),
                WigetTextfieldCustome(
                  controller: typeBookController,
                  textInputType: TextInputType.text,
                  hint: "Nhập loại sách",
                  iconData: Icons.book,
                ),
                SizedBox(height: 16),
                WidgetTextfieldArea(
                  controller: descriptionController,
                  textInputType: TextInputType.multiline,
                  hint: "Nhập mô tả",
                  iconData: Icons.format_indent_decrease,
                ),
              ],
            ),
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          actions: [
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.cancel_outlined, color: Colors.grey),
              label: Text("Huỷ", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                onSubmit(
                  TypeBookModal(
                    id: typeBookModal.id,
                    name_book: nameBookController.text,
                    type_book: typeBookController.text,
                    description: descriptionController.text,
                    image: typeBookModal.image,
                  ),
                );
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.save , color: Colors.white,),
              label: Text("Lưu", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.spaceAround,
          children: List.generate(widget.list.length ,  (index) => CardTypeBook(
            typeBookModal: widget.list[index],
            edit: (typeBookModal) {
              showEditProductDialog(context, typeBookModal, (typeBookModal) {
                TypeBookModal.updateDatabaseTypeBook(
                  typeBookModal,
                  location+"/updateBook" ,
                  () {},
                );
                setState(() {
                  for(int i = 0 ; i < widget.list.length ; i++) {
                    if(widget.list[i].id == typeBookModal.id) {
                      widget.list[i] = typeBookModal ;
                    }
                  }
                });
              },);
            },
            delete: (typeBookModal) {
              TypeBookModal.updateDatabaseTypeBook(
                typeBookModal,
                location+"/deleteBook" ,
                    () {},
              );
              setState(() {
                for(int i = 0 ; i < widget.list.length ; i++) {
                  if(widget.list[i].id == typeBookModal.id) {
                    widget.list.removeAt(i) ;
                  }
                }
              });
            },
          ),),
        ),
      ),
    );
  }
}
