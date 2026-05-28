# Login Screen

Màn hình đăng nhập người dùng.

## Cấu trúc

```
login/
├── login_desktop.dart      # Giao diện desktop
├── login_tablet.dart       # Giao diện tablet
├── login_mobile.dart       # Giao diện mobile
└── cubit/
    ├── login_cubit.dart
    ├── login_state.dart
    └── login_cubit.freezed.dart
```

## Các file

### login_desktop.dart
- Giao diện đăng nhập cho màn hình desktop (> 1200px)
- Layout ngang với form bên phải, hình ảnh bên trái
- Full width form

### login_tablet.dart
- Giao diện đăng nhập cho tablet (600px - 1200px)
- Layout responsive, form chiếm phần lớn

### login_mobile.dart
- Giao diện đăng nhập cho mobile (< 600px)
- Layout dọc, form full width

## Cubit Logic

### login_cubit.dart
**States:**
- `initial` - Trạng thái khởi tạo
- `loading` - Đang xử lý đăng nhập
- `success` - Đăng nhập thành công
- `failure(String message)` - Đăng nhập thất bại

**Methods:**
- `login(email, password)` - Thực hiện đăng nhập
- `validateEmail(email)` - Kiểm tra email
- `validatePassword(password)` - Kiểm tra mật khẩu

## Sử dụng

```dart
BlocProvider(
  create: (_) => LoginCubit(),
  child: LoginDesktopPage(),
)
```

## Form Fields

- **Email** - Nhập email, validate format
- **Password** - Nhập mật khẩu, ẩn text
- **Remember Me** - Checkbox lưu thông tin
- **Forgot Password** - Link quên mật khẩu

## Navigation

- ✅ Đăng nhập thành công → Dashboard
- ❌ Đăng nhập thất bại → Hiển thị error message
- 🔗 Chưa có tài khoản → SignUp
- 🔗 Quên mật khẩu → Forgot Password