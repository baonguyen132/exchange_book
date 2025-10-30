import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

import '../data/ConstraintData.dart';

import 'package:http_parser/http_parser.dart';
class BookModal {

  String? id ;
  String date_purchase;
  String price;
  String description  ;
  String status ;
  String quantity ;
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
    required this.quantity,
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
      "quantity": quantity,
      "image": image,
      "id_user": id_user,
      "id_type_book": id_type_book,
    };
  }
  factory BookModal.fromJson(Map<String, dynamic> json) {
    return BookModal(
      id: json['id'],
      date_purchase: json['date_purchase'],
      price: json['price'],
      description: json['description'],
      status: json['status'],
      quantity: json['quantity'],
      image: json['image'],
      id_user: json['id_user'],
      id_type_book: json['id_type_book'],
    );
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

  static Future<List<dynamic>> exporUserBook(String id) async {
    final respone = await http.post(
      Uri.parse("$location/exportMyBook"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id_user": id,
      }),
    ) ;

    List<dynamic> data = jsonDecode(respone.body) ;
    return data ;
  }

  static Future<List<dynamic>> exportBook(String id) async {
    final response = await http.post(
      Uri.parse("$location/exportBook"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id_user": id,
      }),
    ) ;

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load books: ${response.statusCode}");
    }
  }

  static Future<String> scanImage(File image) async {
    try {
      var uri = Uri.parse(apiAI); // Đổi IP nếu cần
      var request = http.MultipartRequest('POST', uri);

      var mimeType = lookupMimeType(image.path) ?? 'image/jpeg';

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType.parse(mimeType),
      ));
      request.fields.addAll({"link": "scanTypeBook"});

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(responseBody);
        final data = jsonDecode(jsonResponse[0]["data"]) ;
        return data["name_book"];

      } else {
        print("Upload thất bại! Mã lỗi: ${response.statusCode}");
        return "";
      }
    } catch (e) {
      print("Lỗi khi upload ảnh: $e");
      return "";
    }
  }


  static Future<dynamic> uploadImageAndExportTypeBook(File _image, String name_book) async {
    try {

      var uri = Uri.parse("$location/upload_image_book"); // Đổi IP nếu cần
      var request = http.MultipartRequest('POST', uri);

      var mimeType = lookupMimeType(_image.path) ?? 'image/jpeg';

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _image.path,
        contentType: MediaType.parse(mimeType),
      ));
      request.fields['name_book'] = name_book ;

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

  static Future<dynamic> scanBooks(String id, String nameBook) async {
    try {
      final uri = Uri.parse('$location/scan_books'); // Địa chỉ API
      final request = http.MultipartRequest('POST', uri);

      // Gửi dữ liệu dạng form
      request.fields['id'] = id;
      request.fields['name_book'] = nameBook.trim();

      // Gửi yêu cầu
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      // Kiểm tra mã trạng thái phản hồi
      if (response.statusCode == 200) {
        try {
          final data = json.decode(responseBody);
          return data;
        } catch (e) {
          print('Lỗi khi parse JSON: $e');
          print('Nội dung phản hồi: $responseBody');
          return null;
        }
      } else {
        print('Yêu cầu thất bại! Mã lỗi: ${response.statusCode}');
        print('Nội dung phản hồi: $responseBody');
        return null;
      }
    } catch (e) {
      print('Lỗi khi gọi API scanTypeBook: $e');
      return null;
    }
  }
}