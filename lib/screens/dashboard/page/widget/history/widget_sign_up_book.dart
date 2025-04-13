import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_admin/data/ConstraintData.dart';
import 'package:project_admin/model/BookModal.dart';
import 'package:project_admin/model/TypeBookModal.dart';
import 'package:project_admin/model/UserModal.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/widget_button_custom.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/widget_text.dart';
import 'package:project_admin/screens/dashboard/widget/card/card_item.dart';
import 'package:project_admin/theme/theme.dart';

import '../../../../../util/widget_textfield_area.dart';
import '../../../../../util/wiget_textfield_custome.dart';
import '../../../widget/card/card_item_image.dart';

class WidgetSignUpBook extends StatefulWidget {
  UserModel user ;

  WidgetSignUpBook({super.key , required this.user});

  @override
  State<WidgetSignUpBook> createState() => _WidgetSignUpBookState();
}

class _WidgetSignUpBookState extends State<WidgetSignUpBook> {
  final ImagePicker _picker = ImagePicker();
  TypeBookModal? typeBookModal  ;
  File? _image;

  TextEditingController date_purchase = TextEditingController() ;
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();



  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null)  {
      typeBookModal = null ;
      _image = File(pickedFile.path);
      TypeBookModal data = (await BookModal.uploadImageScan(_image!))! ;
      setState(() {
        typeBookModal = data ;
      });
    }
  }

  Widget loadData() {
    return Column(
      children: [
        Container(
          width: min(MediaQuery.of(context).size.width, 400),
          padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.2),
                  offset: Offset(0, 3), // Bóng dịch xuống một chút
                  blurRadius: 10, // Làm mềm bóng hơn
                  spreadRadius: 2, // Giảm độ lan để giữ rõ viền bo
                )
              ],
              color: Theme.of(context).colorScheme.mainCard
          ),
          child: Row(
            children: [
              CardItemImage(
                width: 100,
                height: 100,
                borderRadius: 10,
                heart: false,
                link: "${location}/${typeBookModal?.image}",
              ),
              SizedBox(width: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WidgetText(icon: Icons.book, tilte: "Tên sách", content: typeBookModal!.name_book),
                  WidgetText(icon: Icons.book, tilte: "Loại: ", content: typeBookModal!.type_book),
                  WidgetText(icon: Icons.book, tilte: "Mô tả: ", content: "\n${typeBookModal?.description}"),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 20,)
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
          WigetTextfieldCustome(controller: date_purchase, textInputType: TextInputType.datetime, hint: "Nhập ngày mua sách", iconData: Icons.date_range_outlined),
          SizedBox(height: 20,),
          WigetTextfieldCustome(controller: price, textInputType: TextInputType.number, hint: "giá", iconData: Icons.price_change_sharp),
          SizedBox(height: 20,),

          WidgetTextfieldArea(controller: description, textInputType: TextInputType.multiline, hint: "Nhập mô tả", iconData: Icons.format_indent_decrease) ,
          SizedBox(height: 20,),

          typeBookModal != null ? loadData() : Container(),

          WidgetButtonCustom(
              handle: ()  {
                final typeBookModal = this.typeBookModal;

                if(typeBookModal != null) {
                  BookModal.updateDatabaseBook(BookModal(date_purchase: date_purchase.text , price: price.text, description: description.text, status: "1", id_user: widget.user.id.toString(), id_type_book: typeBookModal.id.toString()), "$location/insertBook", () {

                  },);
                }

              },
              text: "Thêm sản phẩm"
          )
        ],
      ),
    );
  }
}
