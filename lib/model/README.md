# Model Directory

Tầng Model - Quản lý dữ liệu và tương tác API.

## Các file Model

### BookModal.dart
- Định nghĩa lớp Book với các thuộc tính (id, title, author, price, image...)
- **API Methods:**
  - `exportBook()` - Xuất danh sách sách
  - `scanImage()` - Quét ảnh sách
  - `uploadImage()` - Tải ảnh lên server
  - `getBooks()` - Lấy danh sách sách
  - `getBookDetail(id)` - Lấy chi tiết sách

### UserModel.dart
- Định nghĩa lớp User (id, name, email, phone, avatar, points...)
- **Authentication Methods:**
  - `login(email, password)` - Đăng nhập
  - `signup(userData)` - Đăng ký
  - `logout()` - Đăng xuất
  - `getUserProfile()` - Lấy thông tin người dùng
  - `updateProfile(userData)` - Cập nhật profile

### TypeBookModal.dart
- Model loại sách (category)
- `uploadImage()` - Upload ảnh category
- `getTypes()` - Lấy danh sách loại sách

### TransactionModal.dart
- Model giao dịch điểm
- `transferPoints(userId, points)` - Chuyển điểm
- `getTransactionHistory()` - Lịch sử giao dịch

### CartModal.dart
- Model giỏ hàng
- `addToCart(bookId, quantity)` - Thêm vào giỏ
- `removeFromCart(bookId)` - Xóa khỏi giỏ
- `checkout()` - Thanh toán

### MenuModal.dart
- Model menu item cho navigation

## Cấu trúc Model

```dart
@freezed
class Book with _$Book {
  factory Book({
    required String id,
    required String title,
    required String author,
    required double price,
    required String imageUrl,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
```

## Quy tắc

- Sử dụng **Freezed** cho immutability
- Hàm API phải return **Future<T>**
- Handle lỗi với try-catch và throw Exception
- Serialize/Deserialize JSON với factory methods