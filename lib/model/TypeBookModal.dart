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



  static Future<void> updateDatabaseTypeBook(TypeBookModal user , String path , Function () handle ) async {
    final response = await http.post(
      Uri.parse(path),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()), // Chuyển đổi model thành JSON
    );
    if (response.statusCode == 200) {
      handle() ;
    } else {
      print("Lỗi: ${response.body}");
    }
  }

  static Future<List<TypeBookModal>> exportBook(Function () handle) async {
    List<TypeBookModal> list = [] ;
    
    final respone = await http.post(
      Uri.parse(location+"/exportBook"),
      headers: {"Content-Type": "application/json"},
    ) ;

    List<dynamic> data = jsonDecode(respone.body) ;
    for(var item in data) {
      list.add(TypeBookModal(id: item[0].toString() , name_book: item[1], type_book: item[2], description:item[4], image: item[3]));
    }
    return list ;

  }
}