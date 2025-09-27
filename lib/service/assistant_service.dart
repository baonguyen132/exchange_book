import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> chatWithAI(
  String message,
  Function(String reply) handleSuccessful, // callback nhận dữ liệu
  Function(String error) handleFail,
) async {
  try {
    final response = await http.post(
      Uri.parse("https://e50ab2dbfd14.ngrok-free.app/api/chat"),
      headers: {
        "Content-Type": "application/json",
        "ngrok-skip-browser-warning": "true"
      },
      body: jsonEncode({"message": message}),
    );


    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      // Thay đổi để lấy đúng field từ response
      final Map<String , dynamic> dataMessage = jsonDecode(data["gemini_reply"]);
      handleSuccessful(dataMessage["message"] ?? "Không có dữ liệu từ server");
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
      Uri.parse("https://e50ab2dbfd14.ngrok-free.app/api/create_question"),
      headers: {
        "Content-Type": "application/json",
        "ngrok-skip-browser-warning": "true"
      },
      body: jsonEncode({"message": message}),
    );


    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      // Thay đổi để lấy đúng field từ response
      final Map<String , dynamic> dataMessage = jsonDecode(data["gemini_reply"]);
      String dataQuestionString = dataMessage["message"] ;
      handleSuccessful(dataQuestionString ?? "");
    } else {
      handleFail("Lỗi server: ${response.statusCode}");
    }
  } catch (e) {
    handleFail("Lỗi kết nối: $e");
  }
}
