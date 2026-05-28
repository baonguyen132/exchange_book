import 'dart:convert';
import 'package:http/http.dart' as http;

import '../data/ConstraintData.dart';

Future<void> chatWithAI(
  String message,
  Function(String reply) handleSuccessful, // callback nhận dữ liệu
  Function(String error) handleFail,
) async {
  try {
    final response = await http.post(
      Uri.parse(apiAI),
      headers: {
        "Content-Type": "application/json",
        "ngrok-skip-browser-warning": "true"
      },
      body: jsonEncode(
          {
            "link": "chat",
            "message": message,
            "sessionId": "898387123"
          }
      ),
    );



    if (response.statusCode == 200) {

      final List<dynamic> data = jsonDecode(response.body);
      handleSuccessful(data[0]["output"] ?? "Không có dữ liệu từ server");
    } else {
      handleFail("Lỗi server: ${response.statusCode}");
    }
  } catch (e) {
    handleFail("Lỗi kết nối: $e");
  }
}


Future<void> createQuestion(
    String message,
    Function(String data) handleSuccessful, // callback nhận dữ liệu
    Function(String error) handleFail,
    ) async {
  try {
    final response = await http.post(
      Uri.parse(apiAI),
      headers: {
        "Content-Type": "application/json",
        "ngrok-skip-browser-warning": "true"
      },
      body: jsonEncode(
          {
            "link": "question",
            "message": "Hãy tạo 5 câu hỏi trắc nghiệm các môn học lớp $message dưới dạng một mảng JSON hợp lệ. Mỗi câu hỏi là một đối tượng có các trường: 'content', 'A', 'B', 'C', 'D', 'correct'. Sử dụng dấu ngoặc kép (\") cho các phím và giá trị chuỗi. Tuyệt đối không bao gồm markdown (như ```json) hay bất kỳ văn bản giải thích nào, chỉ trả về mảng JSON.",
          }
      ),
    );


    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      
      String dataQuestionString = data[0]["output"] ;
      print(dataQuestionString);
      handleSuccessful(dataQuestionString ?? "");
    } else {
      handleFail("Lỗi server: ${response.statusCode}");
    }
  } catch (e) {
    handleFail("Lỗi kết nối: $e");
  }
}


Future<void> postFaceBook(
    String title,
    String description,
    Function() handleSuccessful, // callback nhận dữ liệu
    Function(String error) handleFail,
    ) async {
  try {
    final response = await http.post(
      Uri.parse(apiAI),
      headers: {
        "Content-Type": "application/json",
        "ngrok-skip-browser-warning": "true"
      },
      body: jsonEncode(
          {
            "link": "postFacebook",
            "title": title,
            "description": description,
          }
      ),
    );


    if (response.statusCode == 200) {

      handleSuccessful();
    } else {
      handleFail("Lỗi server: ${response.statusCode}");
    }
  } catch (e) {
    handleFail("Lỗi kết nối: $e");
  }
}