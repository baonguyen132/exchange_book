import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/ConstraintData.dart';

class CartModal {
  String? id ;
  String status;
  String address;
  int total  ;
  int id_user ;
  int id_seller ;

  CartModal({
    this.id,
    required this.status,
    required this.address,
    required this.total,
    required this.id_user,
    required this.id_seller
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "status": status,
      "address": address,
      "total": total,
      "id_user": id_user,
    };
  }

  static Future<void> uploadCart(
      Map<String, String> data,
      String address,
      String total,
      String path,
      String id_user ,
      Function() handleSuccessful,
      Function() handleFail,
      ) async {
    final response = await http.post(
      Uri.parse(path),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({  // ← sửa chỗ này
        "data": data,
        "address": address,
        "total": total,
        "id_user": id_user
      }),
    );

    if (response.statusCode == 200) {
      handleSuccessful();
    } else {
      handleFail();
    }
  }

  static Future<List<dynamic>> exportCartPurchase(String id_user) async {
    final response = await http.post(
      Uri.parse("$location/export_cart_purchase"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"id_user": id_user})
    ) ;

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load books: ${response.statusCode}");
    }
  }

  static Future<List<dynamic>> exportCartSeller(String id_user) async {
    final response = await http.post(
        Uri.parse("$location/export_cart_seller"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id_user": id_user})
    ) ;

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load books: ${response.statusCode}");
    }
  }

  static Future<List<dynamic>> exportItemCart(String idCart) async {
    final response = await http.post(
        Uri.parse("$location/export_item_cart"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id_cart": idCart})
    ) ;

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load books: ${response.statusCode}");
    }
  }


  static Future<void> updateStateCart(String id_user, String id_cart ,String state , String total, Function () handleSuccessful , Function () handleFail ) async {
    final response = await http.post(
      Uri.parse("$location/update_state_cart"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id_user": id_user,
        "id_cart": id_cart,
        "state": state,
        "total": total
      }),
    ) ;
    if (response.statusCode == 200) {
      handleSuccessful() ;
    } else {
      handleFail() ;
    }
  }


}