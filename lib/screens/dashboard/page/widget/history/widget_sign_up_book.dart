import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_admin/data/ConstraintData.dart';
import 'package:project_admin/model/BookModal.dart';
import 'package:project_admin/model/TypeBookModal.dart';
import 'package:project_admin/model/UserModal.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/card_book.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/widget_button_custom.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/widget_text.dart';


import '../../../../../util/widget_textfield_area.dart';
import '../../../../../util/wiget_textfield_custome.dart';

class WidgetSignUpBook extends StatefulWidget {
  UserModel user ;
  Function (BookModal bookmodal) insert;

  WidgetSignUpBook({super.key , required this.user , required this.insert});

  @override
  State<WidgetSignUpBook> createState() => _WidgetSignUpBookState();
}

class _WidgetSignUpBookState extends State<WidgetSignUpBook> {
  final ImagePicker _picker = ImagePicker();
  TypeBookModal? typeBookModal = null  ;
  String path = "" ;
  File? _image;
  String error = "" ;

  TextEditingController date_purchase = TextEditingController() ;
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController quantity = TextEditingController();




  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null)  {
      _image = File(pickedFile.path);
      var  jsonResponse = (await BookModal.uploadImageScan(_image!))! ;

      var data = jsonResponse["data"];

      setState(() {
        typeBookModal = TypeBookModal(id: data[0].toString() ,name_book: data[1], type_book: data[2], price: data[3].toString(), description: data[5], image: data[4]) ;
        path = jsonResponse["path"];
      });
    }
  }

  Widget loadData() {
    return Column(
      children: [
        CardBook(
            width: min(MediaQuery.of(context).size.width, 400),
            link: typeBookModal!.image,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WidgetText(icon: Icons.book, title: "Tên sách", content: typeBookModal!.name_book),
                WidgetText(icon: Icons.book, title: "Loại: ", content: typeBookModal!.type_book),
                WidgetText(icon: Icons.book, title: "Mô tả: ", content: "\n${typeBookModal?.description}"),
                WidgetText(icon: Icons.book, title: "Giá gốc: ", content: "\n${typeBookModal?.price}"),
              ],
            ),
        ),
        const SizedBox(height: 20,),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Container(
            height: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(width: 2 , color: Colors.blue)
            ),
            child: Row(
              children: [
                Container(
                  width: 200,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Colors.blue
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _pickImage(ImageSource.gallery) ;
                    },
                    child:const  MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
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
                Expanded(
                    child: Center(
                      child: Text("Upload hình ảnh sách"),
                    )
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          WigetTextfieldCustome(
              controller: date_purchase,
              textInputType: TextInputType.datetime,
              hint: "DDMMYYYY",
              iconData: Icons.edit_calendar,
              onChange: (value) {
                if (value.length == 8) {
                  String formatted = formatIDToDate(value);
                  setState(() {
                    date_purchase.text = formatted;
                  });
                }
            },
          ),
          SizedBox(height: 20,),
          WigetTextfieldCustome(controller: price, textInputType: TextInputType.number, hint: "giá", iconData: Icons.price_change_sharp),
          SizedBox(height: 20,),
          WigetTextfieldCustome(controller: quantity, textInputType: TextInputType.number, hint: "Số lượng", iconData: Icons.confirmation_number_rounded),
          SizedBox(height: 20,),
          WidgetTextfieldArea(controller: description, textInputType: TextInputType.multiline, hint: "Nhập mô tả", iconData: Icons.format_indent_decrease) ,
          SizedBox(height: 20,),

          typeBookModal != null ? loadData() : Container(),

          WidgetButtonCustom(
              handle: ()  {
                final typeBookModal = this.typeBookModal;

                if(typeBookModal != null) {
                  if(double.parse(price.text) < double.parse(typeBookModal.price) * 0.5) {
                    widget.insert(
                        BookModal(
                            date_purchase: date_purchase.text ,
                            price: price.text,
                            description: description.text,
                            status: "1",
                            quantity: quantity.text,
                            image: path,
                            id_user: widget.user.id.toString(),
                            id_type_book: typeBookModal.id.toString()
                        ));
                    setState(() {
                      date_purchase.text = "" ;
                      price.text = "" ;
                      this.typeBookModal = null ;
                      description.text = "" ;
                      path = "" ;
                      error="";
                    });
                  }
                  else {
                    setState(() {
                      error = "Giá phải nhỏ hơn 50% giá gốc" ;
                    });
                  }
                }

              },
              text: "Thêm sản phẩm"
          ),
          SizedBox(height: 20,),
          Text(
            error,
            style: TextStyle(color: Colors.red),
            maxLines: 2, // hoặc nhiều hơn tùy ý
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
