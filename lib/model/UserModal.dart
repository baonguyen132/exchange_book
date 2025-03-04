import 'dart:convert';
import 'package:http/http.dart' as http;

import '../data/ConstraintData.dart';

class UserModel {
  String? id ;
  String name;
  String email;
  String password;
  String cccd;
  String dob;
  String gender;
  String address;
  String token;

  UserModel({
    this.id ,
    required this.name,
    required this.email,
    required this.password,
    required this.cccd,
    required this.dob,
    required this.gender,
    required this.address,
    this.token = "some_token",
  });

  // ✅ Chuyển JSON thành Object
  factory UserModel.fromJson(List<dynamic> json) {
    return UserModel(
      id: json[0].toString(),
      name: json[1].toString() ,
      email: json[2].toString() ,
      password: json[3].toString(),
      cccd: json[5].toString(),
      dob: (json[6]),
      gender: json[7].toString() ,
      address: json[8].toString() ,
      token: json[10].toString() ,
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

  static Future<UserModel?> login(String email, String password) async {
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password
    };
    try {
      final response = await http.post(
        Uri.parse(location+"/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody), // Chuyển đổi model thành JSON
      );
      if(response.statusCode == 200) {
        List<dynamic> json = jsonDecode(response.body);
        return UserModel.fromJson(json);
      }
      else {
        print("Lỗi đăng nhập: ${response.statusCode}");
        return null;
      }
    }
    catch (e) {
      print("Lỗi kết nối API: $e");
      return null;
    }
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

