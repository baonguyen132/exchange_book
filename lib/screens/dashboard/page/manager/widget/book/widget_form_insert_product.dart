import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:exchange_book/model/TypeBookModal.dart';
import 'package:exchange_book/util/widget_text_field_area.dart';

import '../../../../../../util/widget_text_field_custom.dart';
import '../../../client/widget/manage/widget_button_custom.dart';


class WidgetFormInsertProduct extends StatefulWidget {
  final Function (TypeBookModal typeBookModal ) insert ;
  const WidgetFormInsertProduct({super.key , required this.insert});

  @override
  State<WidgetFormInsertProduct> createState() => _WidgetFormInsertProductState();
}

class _WidgetFormInsertProductState extends State<WidgetFormInsertProduct> {
  final ImagePicker _picker = ImagePicker();
  String path = "" ;
  File? _image;

  IconData icon = Icons.close ;
  Color color = Colors.red ;

  TextEditingController nameBook = TextEditingController() ;
  TextEditingController typeBook = TextEditingController();
  TextEditingController price = TextEditingController() ;

  TextEditingController description = TextEditingController();



  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null)  {
      path = "" ;
      _image = File(pickedFile.path);
      List<String> data = (await TypeBookModal.uploadImageScan(_image!))! ;
      setState(() {
        path = data[0];
        nameBook.text = "${data[1]} ${data[2]}" ;
        typeBook.text = "Sách lớp ${data[2]}"  ;
        icon = Icons.check ;
        color = Colors.green ;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        WidgetTextFieldCustom(
            controller: nameBook,
            textInputType: TextInputType.text,
            hint: "Nhập tên sách",
            iconData: Icons.drive_file_rename_outline
        ),
        const SizedBox(height: 20,),
        WidgetTextFieldCustom(
            controller: typeBook,
            textInputType: TextInputType.text,
            hint: "Nhập loại sách",
            iconData: Icons.book
        ),
        const SizedBox(height: 20,),

        WidgetTextFieldCustom(
            controller: price,
            textInputType: TextInputType.text,
            hint: "Nhập giá sách",
            iconData: Icons.price_change_outlined
        ),
        const SizedBox(height: 20,),
        Container(
          height: 55,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(width: 2 , color: Colors.blue)
          ),
          child: Row(
            children: [
              Container(
                width: 200,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(color: Colors.blue),
                child: GestureDetector(
                  onTap: () {_pickImage(ImageSource.gallery) ;},
                  child:const  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, color: Colors.white,),
                        SizedBox(width: 10,),
                        Text(
                          "Chọn ảnh",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(child: Center(child: Text(path != "" ? "Hình ảnh đã upload" : "Chưa có ảnh"),)
              )
            ],
          ),
        ),
        const SizedBox(height: 20,),

        WidgetTextFieldArea(
            controller: description,
            textInputType: TextInputType.multiline,
            hint: "Nhập mô tả",
            iconData: Icons.format_indent_decrease,
            onChange: (value) {},
        ) ,
        const SizedBox(height: 20,),
        WidgetButtonCustom(
            handle: () {
              widget.insert(TypeBookModal(name_book: nameBook.text, type_book: typeBook.text, price: price.text , description: description.text ,image: path));
              nameBook.clear();
              typeBook.clear();
              price.clear();
              description.clear();
              path = "" ;
            },
            text: "Thêm sản phẩm"
        )
      ],
    );
  }
}