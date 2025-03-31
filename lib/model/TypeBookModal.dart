import 'dart:convert';
import 'package:http/http.dart' as http;

import '../data/ConstraintData.dart';

class TypeBookModal {
  String? id;
  String name_book;
  String type_book;
  String description ;
  String image;

  TypeBookModal({
    this.id,
    required this.name_book,
    required this.type_book,
    required this.description,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name_book": name_book,
      "type_book": type_book,
      "description": description,
      "image": image,
    };
  }



  static Future<void> insertBook(TypeBookModal user, Function () handle) async {

    final response = await http.post(
      Uri.parse(location+"/insertBook"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()), // Chuyển đổi model thành JSON
    );

    if (response.statusCode == 200) {
      handle() ;
    } else {
      print("Lỗi: ${response.body}");
    }
  }
}