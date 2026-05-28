# Check OTP Screen

Màn hình xác minh mã OTP sau khi đăng nhập hoặc đăng ký.

## Cấu trúc

```
checkopt/
├── checkopt_desktop.dart
├── checkopt_tablet.dart
├── checkopt_mobile.dart
└── cubit/
    ├── checkopt_cubit.dart
    ├── checkopt_state.dart
    └── checkopt_cubit.freezed.dart
```

## Các file

### checkopt_*.dart
- Giao diện nhập OTP responsive
- Pin code input widget
- Countdown timer

## Cubit Logic

### checkopt_cubit.dart
**States:**
- `initial` - Trạng thái khởi tạo
- `loading` - Đang kiểm tra OTP
- `success` - OTP hợp lệ
- `failure(String message)` - OTP sai
- `expired` - OTP hết hạn
- `resendCountdown(int seconds)` - Countdown gửi lại

**Methods:**
- `verifyOTP(code)` - Kiểm tra mã OTP
- `resendOTP()` - Gửi lại OTP
- `startCountdown()` - Bắt đầu đếm ngược

## OTP Input

- **Pin Code Input** - 6 chữ số
- **Auto submit** - Tự động kiểm tra khi nhập đủ 6 số
- **Resend Button** - Gửi lại OTP (có countdown)
- **Time remaining** - Hiển thị thời gian còn lại

## Validation

✅ OTP phải 6 chữ số
✅ OTP phải khớp với code gửi
✅ OTP không hết hạn
✅ Chỉ được resend sau timeout

## Navigation

- ✅ OTP đúng → Dashboard (Login) hoặc Next Step (SignUp)
- ❌ OTP sai → Hiển thị error
- 🔗 Resend OTP → Gửi lại mã
- 🔗 Quay lại → Login