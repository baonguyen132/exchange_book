import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../data/ConstraintData.dart';
import 'package:mime/mime.dart';


import 'package:http_parser/http_parser.dart';

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
  String? status ;
  String point ;

  UserModel({
    this.id ,
    required this.name,
    required this.email,
    required this.password,
    required this.cccd,
    required this.dob,
    required this.gender,
    required this.address,
    required this.point,
    this.status ,
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
      address: json[9].toString() ,
      point: json[10].toString(),
      token: json[10].toString() ,
      status: json[4].toString(),

    );
  }
  factory UserModel.fromJsons(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"].toString(),
      name: json["name"].toString(),
      email: json["email"].toString(),
      password: json["password"].toString(),
      cccd: json["cccd"].toString(),
      dob: json["dob"].toString(),
      gender: json["gender"].toString(),
      address: json["address"].toString(),
      point: json["point"].toString(),
      token: json["token"].toString(),
      status: json["status"].toString()
    );
  }
  // Chuyển từ Object thành JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "password": password,
      "cccd": cccd,
      "dob": dob,
      "gender": gender,
      "address": address,
      "point": point,
      "status": status ,
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
        Uri.parse("$location/login"),
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
      Uri.parse("$location/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()), // Chuyển đổi model thành JSON
    );

    if (response.statusCode == 200) {
      handle() ;
    } else {
      print("Lỗi: ${response.body}");
    }
  }


  static Future<List<dynamic>> loadDataUser(String id) async {
    final response = await http.post(
      Uri.parse("$location/loadDataUser"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"id_user": id})
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load books: ${response.statusCode}");
    }
  }



  static Future<void> sendCodeOtp(email,number) async {
    Map<String, dynamic> requestBody = {
      "email": email,
      "code": number
    };

    final response = await http.post(
      Uri.parse("$location/sendOtp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print("Phản hồi từ server: ${response.body}");
    } else {
      print("Lỗi: ${response.statusCode}");
    }
  }

  // Hàm lưu dữ liệu
  static saveAccount(String username , String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance() ;
    preferences.setString("username", username);
    preferences.setString("password", password) ;
  }
  static Future<List<String>> loadAccount() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> data = [] ;
    data.add(preferences.getString("username")??"");
    data.add(preferences.getString("password")??"");
    return  data; // Trả về chuỗi rỗng nếu null
  }

  static Future<void> saveUserData(UserModel userData) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(userData.toJson()); // Chuyển đối tượng thành JSON
    await preferences.setString("user_data", jsonString);
  }

  // Hàm load dữ liệu
  static Future<String> loadUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("username") ?? ""; // Trả về chuỗi rỗng nếu null
  }

  static Future<UserModel?> loadUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonString = preferences.getString("user_data");


    if (jsonString != null) {
      try {
        Map<String, dynamic> jsonData = jsonDecode(jsonString);
        return UserModel.fromJsons(jsonData); // Chuyển đổi JSON thành UserModel
      } catch (e) {
        print("Lỗi khi parse JSON: $e");
        return null;
      }
    }
    return null;
  }

  static Future<void> savePointData(int point) async {
    UserModel? userModel = await loadUserData();
    userModel?.point = point.toString() ;
    saveUserData(userModel!);
  }

  static Future<int?> loadPointData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonString = preferences.getString("user_data");
    if (jsonString != null) {
      try {
        Map<String, dynamic> jsonData = jsonDecode(jsonString);
        UserModel userModel = UserModel.fromJsons(jsonData) ;
        return int.parse(userModel.point); // Chuyển đổi JSON thành UserModel
      } catch (e) {
        print("Lỗi khi parse JSON: $e");
        return null;
      }
    }
    return null;
  }





  // Hàm xoá dữ liêuj
  static Future<void> removeUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("user_data"); // Xóa dữ liệu user
    print("Dữ liệu người dùng đã bị xoá!");
  }

  static Future<void> uploadImage(File _image, String cccd , String status , String id ) async {
    if (_image == null) {
      print("Không có ảnh để upload");
      return;
    }

    try {
      var uri = Uri.parse("$location/upload_image"); // Đổi IP nếu cần
      var request = http.MultipartRequest('POST', uri);

      request.fields['number'] = cccd;

      request.fields['status'] = status ;

      request.fields['id'] = id ;

      // Lấy MIME type (nếu không tìm thấy, mặc định là image/jpeg)
      var mimeType = lookupMimeType(_image!.path) ?? 'image/jpeg';

      // Thêm file ảnh
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _image!.path,
        contentType: MediaType.parse(mimeType),
      ));

      // Gửi request
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print("Upload thành công!");
        print("Server response: $responseBody");
      } else {
        print("Upload thất bại! Mã lỗi: ${response.statusCode}");
        print("Server response: $responseBody");
      }
    } catch (e) {
      print("Lỗi khi upload ảnh: $e");
    }
  }

  static Future<String> exportImageAva(String id) async {
    try {
      var uri = Uri.parse("$location/export_image_avata"); // API đúng
      var response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id": id}),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse.containsKey("path")) {
          return jsonResponse["path"][0].toString();
        }
      }
    } catch (e) {
      print("Lỗi kết nối API: $e");
      return "";
    }
    return "";
  }

  static Future<UserModel?> exportUser(String id) async {
    final response = await http.post(
      Uri.parse("$location/loadUser"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id_user": id,
      }),
    ) ;

    List<dynamic> data = jsonDecode(response.body) ;
    return UserModel.fromJson(data) ;
  }




}

