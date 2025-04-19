import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:project_admin/model/TypeBookModal.dart';

import '../data/ConstraintData.dart';

import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
class BookModal {

  String? id ;
  String date_purchase;
  String price;
  String description  ;
  String status ;
  String image ;
  String id_user;
  String id_type_book ;

  BookModal({
    this.id,
    required this.date_purchase,
    required this.price,
    required this.description,
    required this.status,
    required this.image,
    required this.id_user,
    required this.id_type_book,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "date_purchase": date_purchase,
      "price": price,
      "description": description,
      "status": status,
      "image": image,
      "id_user": id_user,
      "id_type_book": id_type_book,
    };
  }

  static Future<void> updateDatabaseBook(BookModal bookModal , String path , Function () handleSuccessful , Function () handleFail ) async {
    final response = await http.post(
      Uri.parse(path),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(bookModal.toJson()), // Chuyển đổi model thành JSON
    );
    if (response.statusCode == 200) {
      handleSuccessful() ;
    } else {
      handleFail() ;
    }
  }

  static Future<List<dynamic>> exportMyBook(String id, Function () handle) async {
    final respone = await http.post(
      Uri.parse(location+"/exportMyBook"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id_user": id,
      }),
    ) ;

    List<dynamic> data = jsonDecode(respone.body) ;
    return data ;
  }


  static Future<dynamic> uploadImageScan(File _image) async {
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

        return json.decode(responseBody);

      } else {
        print("Upload thất bại! Mã lỗi: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Lỗi khi upload ảnh: $e");
      return null;
    }
  }
}