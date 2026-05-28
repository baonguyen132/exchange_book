# Exchange Book - Lib Directory

Thư mục `lib/` chứa toàn bộ mã nguồn chính của ứng dụng Flutter Exchange Book.

## Cấu trúc thư mục

### 📁 `data/`
Chứa các file dữ liệu và hằng số toàn cầu của ứng dụng.

- **ConstraintData.dart** - Các hằng số, API endpoints, và hàm utility toàn cầu
- **SideMenuData.dart** - Dữ liệu menu điều hướng cho sidebar

**Mục đích**: Tập trung các hằng số, cấu hình và dữ liệu tĩnh dùng chung toàn ứng dụng.

---

### 📁 `model/`
Định nghĩa các model dữ liệu và logic tương tác với API server.

- **BookModal.dart** - Model sách với các method API (exportBook, scanImage, uploadImage...)
- **UserModel.dart** - Model người dùng, quản lý authentication và user data
- **TypeBookModal.dart** - Model loại sách với upload ảnh và quản lý database
- **TransactionModal.dart** - Model giao dịch, chuyển điểm
- **CartModal.dart** - Model giỏ hàng
- **MenuModal.dart** - Model menu item

**Mục đích**: Đây là tầng Model trong MVC, xử lý serialization/deserialization JSON và gọi API.

---

### 📁 `screens/`
Các màn hình chính của ứng dụng, được chia theo tính năng.

#### **`login/`** - Các màn hình đăng nhập
- `login_desktop.dart` - Giao diện đăng nhập cho desktop
- `login_tablet.dart` - Giao diện đăng nhập cho tablet
- `cubit/` - BLoC logic cho màn hình đăng nhập

#### **`signup/`** - Các màn hình đăng ký
- Xử lý đăng ký tài khoản mới

#### **`checkopt/`** - Xác minh OTP
- Màn hình kiểm tra mã OTP khi đăng nhập/đăng ký

#### **`scan/`** - Quét mã QR
- `scan_qr_code.dart` - Màn hình quét QR code
- `widget/` - Các widget hỗ trợ quét

#### **`dashboard/`** - Trang chính của ứng dụng
- **Cấu trúc:**
  - `cubit/` - Quản lý state dashboard
  - `page/`
    - **`client/`** - Các tính năng cho người dùng thường
      - `home.dart` - Trang chủ
      - `product.dart` - Danh sách sản phẩm
      - `profile.dart` - Hồ sơ người dùng
      - `card_detail.dart` - Chi tiết sản phẩm
      - `manage_point.dart` - Quản lý điểm
      - `add_point.dart` - Nạp điểm
      - `assistant.dart` - Trợ lý AI
      - `question.dart` - Quiz
      - `contribute_ideas.dart` - Đóng góp ý kiến
      - `tranfer_for_user.dart` - Chuyển điểm cho người khác
      - `cubit/` - BLoC cho từng tính năng
      - `widget/` - Các component UI tái sử dụng
    - **`manager/`** - Các tính năng admin
      - `home_admin.dart` - Dashboard admin
      - `book.dart` - Quản lý sách
      - `post_facebook.dart` - Đăng bài lên Facebook
      - `cubit/` - BLoC cho admin
      - `widget/` - Các component UI admin

**Mục đích**: Tách biệt logic màn hình, quản lý state với BLoC pattern.

---

### 📁 `service/`
Các dịch vụ xử lý logic phức tạp, tương tác với API bên ngoài.

- **AssistantService.dart** - Tích hợp với AI (Gemini), tạo quiz, đăng Facebook

**Mục đích**: Tách biệt logic nghiệp vụ phức tạp ra khỏi các màn hình.

---

### 📁 `theme/`
Cấu hình chủ đề (theme) của ứng dụng.

- **theme.dart** - Định nghĩa các theme (light/dark mode), màu sắc, typography

**Mục đích**: Tập trung quản lý design system của ứng dụng.

---

### 📁 `util/`
Các hàm utility và widget tái sử dụng.

- **WidgetTextFieldCustom.dart** - Text input tùy chỉnh
- **WidgetTextFieldArea.dart** - Text area tùy chỉnh
- Các hàm helper khác

**Mục đích**: Chứa các component UI dùng chung và helper function.

---

### 📁 `widget/`
Các component/widget dùng chung toàn ứng dụng.

- **`card/`** - Các loại card
  - `card_item_image.dart` - Card hiển thị sản phẩm với ảnh
  - ...
- **MyDrawer** - Drawer điều hướng
- **BottomNavBar** - Bottom navigation bar

**Mục đích**: Chứa các component UI tái sử dụng nhiều nơi trong ứng dụng.

---

### 📄 **main.dart** & **my_app.dart**
- **main.dart** - Entry point của ứng dụng
- **my_app.dart** - Widget root, cấu hình MaterialApp

---

## Quy ước code

### Cấu trúc thư mục
```
feature/
  ├── page/
  │   └── feature_page.dart       # Màn hình chính
  ├── cubit/
  │   ├── feature_cubit.dart
  │   ├── feature_state.dart
  │   └── feature_cubit.freezed.dart
  └── widget/
      └── custom_widget.dart      # Component con
```

### BLoC/Cubit
- Dùng **Freezed** cho state immutability
- Mỗi tính năng lớn có một Cubit riêng
- State được chia nhỏ theo logic: `initial`, `loading`, `loaded`, `error`

### Naming Convention
- **Màn hình**: `PascalCase` (vd: `HomePage`, `ProductDetail`)
- **Cubit**: `snake_case` với suffix `_cubit` (vd: `home_cubit.dart`)
- **Widget**: `PascalCase` với prefix `Widget` hoặc `Custom` (vd: `WidgetTextFieldCustom`)
- **Biến private**: `_snake_case` (vd: `_messageController`)

---

## Luồng dữ liệu

```
UI (Widget)
    ↓
    ├─→ BLoC/Cubit (emit state)
    │   ↓
    └─→ Model (gọi API)
        ↓
    Server API
        ↓
    JSON Response
        ↓
    Model (parse)
        ↓
    BLoC/Cubit (update state)
        ↓
    Widget (rebuild UI)
```

---

## Công nghệ sử dụng

- **State Management**: Flutter BLoC, Freezed
- **API**: HTTP package
- **Local Storage**: Shared Preferences
- **Image**: Image Picker, Cached Network Image
- **UI**: Material Design, Custom Widgets

---

## Cách chạy dự án

```bash
# Clone repository
git clone <repo-url>

# Cài dependencies
flutter pub get

# Chạy ứng dụng
flutter run
```

---

## Liên hệ & Hỗ trợ

Nếu có câu hỏi về cấu trúc code, vui lòng tham khảo các file đã bình luận hoặc liên hệ team development.