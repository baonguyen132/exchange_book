import 'dart:convert';
import 'package:http/http.dart' as http;

import '../data/ConstraintData.dart';

class UserModel {
  String name;
  String email;
  String password;
  String cccd;
  String dob;
  String gender;
  String address;
  String token;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.cccd,
    required this.dob,
    required this.gender,
    required this.address,
    this.token = "some_token",
  });

  // Chuyển từ JSON thành Object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      cccd: json['cccd'],
      dob: json['dob'],
      gender: json['gender'],
      address: json['address'],
      token: json['token'] ?? "some_token",
    );
  }

  // Chuyển từ Object thành JSON
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "cccd": cccd,
      "dob": dob,
      "gender": gender,
      "address": address,
      "token": token,
    };
  }

  static Future<void> registerUser(UserModel user , Function () handle) async {

    final response = await http.post(
      Uri.parse(location+"/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()), // Chuyển đổi model thành JSON
    );

    if (response.statusCode == 200) {
      handle() ;
    } else {
      print("Lỗi: ${response.body}");
    }
  }

  static Future<void> sendCodeOtp(email,number) async {
    Map<String, dynamic> requestBody = {
      "email": email,
      "code": number
    };

    final response = await http.post(
      Uri.parse(location+"/sendOtp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print("Phản hồi từ server: ${response.body}");
    } else {
      print("Lỗi: ${response.statusCode}");
    }
  }
}

