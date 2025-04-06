import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:project_admin/model/TypeBookModal.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/widget_button_custom.dart';
import 'package:project_admin/util/widget_textfield_area.dart';

import '../../../../../data/ConstraintData.dart';
import 'package:http/http.dart' as http;

import '../../../../../util/wiget_textfield_custome.dart';

class WidgetFormInsertProduct extends StatefulWidget {
  Function (TypeBookModal typeBookModal ) insert ;
  WidgetFormInsertProduct({super.key , required this.insert});

  @override
  State<WidgetFormInsertProduct> createState() => _WidgetFormInsertProductState();
}

class _WidgetFormInsertProductState extends State<WidgetFormInsertProduct> {
  final ImagePicker _picker = ImagePicker();
  String path = "" ;
  File? _image;

  IconData icon = Icons.close ;
  Color color = Colors.red ;

  TextEditingController name_book = TextEditingController() ;
  TextEditingController type_book = TextEditingController();
  TextEditingController description = TextEditingController();

  static Future<List<String>?> uploadImage(File _image) async {
    try {
      var uri = Uri.parse("$location/upload_image_book"); // Đổi IP nếu cần
      var request = http.MultipartRequest('POST', uri);

      var mimeType = lookupMimeType(_image.path) ?? 'image/jpeg';

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _image.path,
        contentType: MediaType.parse(mimeType),
      ));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(responseBody);

        List<String> data = [];
        data.add(jsonResponse["file_path"]) ;
        data.add(jsonResponse["label"]) ;
        data.add(jsonResponse["number"]) ;

        return data;
      } else {
        print("Upload thất bại! Mã lỗi: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Lỗi khi upload ảnh: $e");
      return null;
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null)  {
      path = "" ;
      _image = File(pickedFile.path);
      List<String> data = (await uploadImage(_image!))! ;
      path = data[0];
      setState(() {
        name_book.text = data[1] ;
        type_book.text = "Sách lớp ${data[2]}"  ;
        icon = Icons.check ;
        color = Colors.green ;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WigetTextfieldCustome(controller: name_book, textInputType: TextInputType.text, hint: "Nhập tên sách", iconData: Icons.drive_file_rename_outline),
          SizedBox(height: 20,),
          WigetTextfieldCustome(controller: type_book, textInputType: TextInputType.text, hint: "Nhập loại sách", iconData: Icons.book),
          SizedBox(height: 20,),

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
                      child: Text("Chưa có ảnh"),
                    )
                )
              ],
            ),
          ),

          SizedBox(height: 20,),

          WidgetTextfieldArea(controller: description, textInputType: TextInputType.multiline, hint: "Nhập mô tả", iconData: Icons.format_indent_decrease) ,
          SizedBox(height: 20,),
          WidgetButtonCustom(
              handle: () {
                widget.insert(TypeBookModal(name_book: name_book.text, type_book: type_book.text, description: description.text ,image: path));
                setState(() {
                  name_book.text = "" ;
                  type_book.text = "" ;
                  description.text = "" ;
                  path = "" ;
                });
              },
              text: "Thêm sản phẩm"
          )
        ],
      ),
    );
  }
}