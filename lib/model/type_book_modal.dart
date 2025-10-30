import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

import '../data/ConstraintData.dart';

import 'package:http_parser/http_parser.dart';
class TypeBookModal {
  String? id;
  String name_book;
  String type_book;
  String price  ;
  String description ;
  String image;

  TypeBookModal({
    this.id,
    required this.name_book,
    required this.type_book,
    required this.price,
    required this.description,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name_book": name_book,
      "type_book": type_book,
      "price": price,
      "description": description,
      "image": image,
    };
  }



  static Future<void> updateDatabaseTypeBook(TypeBookModal typeBookModal , String path , Function () handleSuccessful , Function () handleFail ) async {
    final response = await http.post(
      Uri.parse(path),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(typeBookModal.toJson()), // Chuyển đổi model thành JSON
    );
    if (response.statusCode == 200) {
      handleSuccessful() ;
    } else {
      handleFail();
    }
  }

  static Future<List<TypeBookModal>> exportTypeBook(Function () handle) async {
    List<TypeBookModal> list = [] ;
    
    final respone = await http.get(
      Uri.parse("$location/exportTypeBook"),
      headers: {"Content-Type": "application/json"},
    ) ;

    List<dynamic> data = jsonDecode(respone.body) ;
    for(var item in data) {
      list.add(TypeBookModal(id: item[0].toString() , name_book: item[1], type_book: item[2], price: item[3].toString() ,image: item[4] , description:item[5], ));
    }
    return list ;

  }

  static Future<Map<String, dynamic>?> ScanImage(File _image) async {
    try {
      var uri = Uri.parse(apiAI); // Đổi IP nếu cần
      var request = http.MultipartRequest('POST', uri);

      var mimeType = lookupMimeType(_image.path) ?? 'image/jpeg';

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _image.path,
        contentType: MediaType.parse(mimeType),
      ));
      request.fields.addAll({"link": "scanTypeBook"});

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(responseBody);
        final data = jsonDecode(jsonResponse[0]["data"]) ;
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

  static Future<String> uploadImage(File _image) async {
    try {
      var uri = Uri.parse("$location/upload_type_image_book"); // Đổi IP nếu cần
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

        return jsonResponse["file_path"];
      } else {
        print("Upload thất bại! Mã lỗi: ${response.statusCode}");
        return "";
      }
    } catch (e) {
      print("Lỗi khi upload ảnh: $e");
      return "";
    }
  }

}