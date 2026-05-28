# SignUp Screen

Màn hình đăng ký tài khoản mới.

## Cấu trúc

```
signup/
├── signup_desktop.dart
├── signup_tablet.dart
├── signup_mobile.dart
└── cubit/
    ├── signup_cubit.dart
    ├── signup_state.dart
    └── signup_cubit.freezed.dart
```

## Các file

### signup_*.dart
- Giao diện đăng ký responsive cho desktop, tablet, mobile
- Form đăng ký với các trường thông tin

## Cubit Logic

### signup_cubit.dart
**States:**
- `initial` - Trạng thái khởi tạo
- `loading` - Đang xử lý đăng ký
- `success` - Đăng ký thành công
- `failure(String message)` - Đăng ký thất bại
- `emailExists` - Email đã tồn tại
- `passwordMismatch` - Mật khẩu không trùng

**Methods:**
- `signup(userData)` - Thực hiện đăng ký
- `validateEmail(email)` - Kiểm tra email
- `validatePassword(password)` - Kiểm tra mật khẩu mạnh
- `checkEmailExists(email)` - Kiểm tra email đã tồn tại
- `checkUsername(username)` - Kiểm tra username

## Form Fields

- **Full Name** - Tên đầy đủ
- **Email** - Email (validate + check exists)
- **Phone** - Số điện thoại (validate format)
- **Password** - Mật khẩu (validate độ mạnh)
- **Confirm Password** - Xác nhận mật khẩu
- **Terms & Conditions** - Checkbox đồng ý điều khoản

## Validation Rules

✅ Email phải hợp lệ
✅ Password tối thiểu 8 ký tự, chứa số, chữ hoa, ký tự đặc biệt
✅ Confirm password phải trùng
✅ Phone hợp lệ
✅ Tên không để trống

## Navigation

- ✅ Đăng ký thành công → OTP Verification
- ❌ Đăng ký thất bại → Hiển thị error
- 🔗 Đã có tài khoản → Login