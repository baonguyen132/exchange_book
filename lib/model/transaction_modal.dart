import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/ConstraintData.dart';

class TransactionModel {
  final int id;
  final String transactionDate;
  final int point;
  final int price;
  final bool state;
  final int idUser;
  final String createdAt;
  final String updatedAt;

  TransactionModel({
    required this.id,
    required this.transactionDate,
    required this.point,
    required this.price,
    required this.state,
    required this.idUser,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      transactionDate: json['transaction_date'],
      point: json['point'],
      price: json['price'],
      state: json['state'],
      idUser: json['id_user'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transaction_date': transactionDate,
      'point': point,
      'price': price,
      'state': state,
      'id_user': idUser,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  static Future<void> updateHistoryTransaction({required String point , required String price , required bool state , required String id_user , required Function () successful , required Function () fail}) async {

    final response = await http.post(
      Uri.parse("$location/add-transaction"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "point": point,
        "price": price,
        "state": state,
        "id_user": id_user,
      }), // Chuyển đổi model thành JSON
    );

    if (response.statusCode == 200) {
      successful() ;
    } else {
      fail();
      print("Lỗi: ${response.body}");
    }
  }


  static Future<void> transfer({required String listId , required  listPoint , required String idUser , required Function () successful , required Function () fail}) async {

    final response = await http.post(
      Uri.parse("$location/transfer"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "listId": listId,
        "listPoint": listPoint,
        "idUser": idUser,
      }), // Chuyển đổi model thành JSON
    );

    if (response.statusCode == 200) {
      successful() ;
    } else {
      fail();
      print("Lỗi: ${response.body}");
    }
  }
}
