import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/widget_button_custom.dart';

import '../../../../../data/ConstraintData.dart';
import '../../../../../util/wiget_textfield_custome.dart';

import 'package:http_parser/http_parser.dart';

import 'package:http/http.dart' as http;

class WidgetListProduct extends StatefulWidget {
  const WidgetListProduct({super.key});

  @override
  State<WidgetListProduct> createState() => _WidgetListProductState();
}

class _WidgetListProductState extends State<WidgetListProduct> {
  // List<DocumentSnapshot> products = []; // Danh sách sản phẩm
  // final ImagePicker _picker = ImagePicker();
  // String path = "" ;
  // File? _image;
  //
  // IconData icon = Icons.close ;
  // Color color = Colors.red ;
  
  // Future<void> getData() async {
  //   var collection = FirebaseFirestore.instance.collection('product');
  //   var snapshot = await collection.get();
  //   setState(() {
  //     products = snapshot.docs; // Cập nhật danh sách sản phẩm
  //     print(products) ;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData() ;
  }

  // static Future<String?> uploadImage(File _image) async {
  //   try {
  //     var uri = Uri.parse("$location/upload_image"); // Đổi IP nếu cần
  //     var request = http.MultipartRequest('POST', uri);
  //
  //     var mimeType = lookupMimeType(_image.path) ?? 'image/jpeg';
  //
  //     request.files.add(await http.MultipartFile.fromPath(
  //       'image',
  //       _image.path,
  //       contentType: MediaType.parse(mimeType),
  //     ));
  //
  //     var response = await request.send();
  //     var responseBody = await response.stream.bytesToString();
  //
  //     if (response.statusCode == 200) {
  //       var jsonResponse = json.decode(responseBody);
  //       String imageUrl = jsonResponse["image_path"];
  //       print(imageUrl);
  //       return imageUrl;
  //     } else {
  //       print("Upload thất bại! Mã lỗi: ${response.statusCode}");
  //       return null;
  //     }
  //   } catch (e) {
  //     print("Lỗi khi upload ảnh: $e");
  //     return null;
  //   }
  // }
  //
  // Future<void> _pickImage(ImageSource source) async {
  //   final pickedFile = await _picker.pickImage(source: source);
  //   if (pickedFile != null)  {
  //     path = "" ;
  //     _image = File(pickedFile.path);
  //     path = (await uploadImage(_image!))!;
  //   }
  // }

  // void showEditProductDialog(BuildContext context, ProductModal product , Function(String? ,String, String, int) onSubmit) {
  //
  //     TextEditingController tensp = TextEditingController(text: product.tensp);
  //     TextEditingController loaisp = TextEditingController(text: product.loaisp);
  //     TextEditingController gia = TextEditingController(text: product.gia.toString());
  //
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("Chỉnh sửa sản phẩm"),
  //           content: SingleChildScrollView(
  //             child: Column(
  //               children: [
  //                 WigetTextfieldCustome(controller: tensp, textInputType: TextInputType.text, hint: "Nhập tên sản phẩm", iconData: Icons.drive_file_rename_outline),
  //                 SizedBox(height: 20,),
  //                 WigetTextfieldCustome(controller: loaisp, textInputType: TextInputType.text, hint: "Nhập tên loại sản phẩm", iconData: Icons.bloodtype_outlined),
  //                 SizedBox(height: 20,),
  //
  //                 WigetTextfieldCustome(controller: gia, textInputType: TextInputType.number, hint: "Nhập giá", iconData: Icons.monetization_on),
  //                 SizedBox(height: 20,),
  //                 Row(
  //                   children: [
  //                     Text("Chọn ảnh") ,
  //                     SizedBox(width: 5,) ,
  //
  //
  //                     Icon(icon, color: color,),
  //
  //                     SizedBox(width: 5,) ,
  //                     Expanded(
  //                         child: WidgetButtonCustom(
  //                             handle: () {
  //                               _pickImage(ImageSource.gallery) ;
  //                               setState(() {
  //                                 icon = Icons.check ;
  //                                 color = Colors.green ;
  //                               });
  //                             },
  //                             text: "Chọn"
  //                         )
  //                     )
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //           actions: [
  //            TextButton(
  //              onPressed: () {
  //                Navigator.of(context).pop();
  //              },
  //              child: Text("Huỷ"),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 onSubmit(
  //                  product.id,
  //                  tensp.text,
  //                  loaisp.text,
  //                  int.parse(gia.text),
  //                );
  //                 Navigator.of(context).pop();
  //              },
  //              child: Text("Lưu"),
  //            ),
  //           ],
  //        );
  //       },
  //    );
  //
  // }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Wrap(
        //   alignment: MediaQuery.of(context).size.width > 500 ? WrapAlignment.spaceAround : WrapAlignment.center,
        //   children: products.map((e) => ProductItem(
        //     product: e,
        //     handleDelete: (id) {
        //       ProductModal.deleteProduct(id) ;
        //       getData() ;
        //     },
        //     handleUpdate: (ProductModal product) {
        //       showEditProductDialog(context, product, (id , tensp, loaisp, gia) {
        //         ProductModal.updateProduct(id!, tensp, loaisp, gia, path) ;
        //         path = "" ;
        //         getData() ;
        //       },);
        //     },
        //   )).toList(),
        // ),
        // Container(
        //   width: MediaQuery.of(context).size.width,
        //   height: 100,
        // )
      ],
    );
  }
}
