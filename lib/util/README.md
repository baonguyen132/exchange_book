# Util Directory

Chứa các hàm utility, helpers, và custom widgets dùng chung.

## Các file

### WidgetTextFieldCustom.dart
Custom TextField với styling riêng

**Props:**
- `label` - Nhãn trường
- `hint` - Gợi ý
- `obscure` - Ẩn text (password)
- `onChanged` - Callback khi thay đổi
- `validator` - Validation function

```dart
WidgetTextFieldCustom(
  label: 'Email',
  hint: 'Nhập email',
  onChanged: (value) {},
)
```

### WidgetTextFieldArea.dart
Custom TextArea (Multi-line TextField)

**Props:**
- `maxLines` - Số dòng tối đa
- `minLines` - Số dòng tối thiểu
- `label`, `hint`, `onChanged` - Tương tự TextField

### Các utility functions

**Format Functions:**
- `formatCurrency(double)` - Định dạng tiền tệ
- `formatDateTime(DateTime)` - Định dạng ngày giờ
- `formatPhoneNumber(String)` - Định dạng số điện thoại

**Validation Functions:**
- `isValidEmail(String)` - Kiểm tra email hợp lệ
- `isValidPhoneNumber(String)` - Kiểm tra số điện thoại
- `isStrongPassword(String)` - Kiểm tra mật khẩu mạnh

**Helper Functions:**
- `showSnackBar(context, message)` - Hiển thị snackbar
- `showDialog(context, title, content)` - Hiển thị dialog
- `navigateTo(context, route)` - Điều hướng

## Quy tắc

- Không import thư viện ngoài không cần thiết
- Reuse component thay vì tạo mới
- Utility functions nên pure (không side effects)