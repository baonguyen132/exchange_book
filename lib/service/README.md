# Service Directory

Tầng Service - Xử lý logic nghiệp vụ phức tạp, tích hợp API bên ngoài.

## Các service

### AssistantService.dart
Tích hợp với các dịch vụ AI và Social Media

**Methods:**
- `generateQuiz(topic)` - Tạo quiz từ Gemini AI
- `askAssistant(question)` - Hỏi trợ lý AI
- `postToFacebook(content, image)` - Đăng bài Facebook
- `searchBooks(query)` - Tìm kiếm sách
- `getRecommendations(userId)` - Gợi ý sách

## Quy tắc

```dart
class AssistantService {
  static const String _geminApiKey = 'YOUR_API_KEY';
  
  // Sử dụng static method hoặc singleton pattern
  static Future<String> generateQuiz(String topic) async {
    try {
      // Gọi API
      // Parse response
      return result;
    } catch (e) {
      throw Exception('Failed to generate quiz: $e');
    }
  }
}
```

- Handle errors với try-catch
- Return Future<T> cho async operations
- Sử dụng singleton hoặc static methods
- Tách riêng logic phức tạp khỏi Model và Cubit