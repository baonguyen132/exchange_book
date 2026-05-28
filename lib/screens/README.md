# Screens Directory

Thư mục chứa toàn bộ màn hình (Page) của ứng dụng.

## Cấu trúc

```
screens/
├── login/              # Đăng nhập
├── signup/             # Đăng ký
├── checkopt/           # Xác minh OTP
├── scan/               # Quét QR code
└── dashboard/          # Dashboard chính
    ├── page/
    │   ├── client/     # Tính năng người dùng
    │   └── manager/    # Tính năng admin
    ├── cubit/
    └── widget/
```

## Quy ước naming

- **Tên file**: `snake_case` (vd: `login_desktop.dart`)
- **Tên class**: `PascalCase` (vd: `LoginDesktopPage`)
- **Route name**: `/login`, `/dashboard/home`, `/dashboard/admin`

## Responsive Design

- `*_desktop.dart` - Giao diện desktop (> 1200px)
- `*_tablet.dart` - Giao diện tablet (600px - 1200px)
- `*_mobile.dart` - Giao diện mobile (< 600px)

## Ví dụ cấu trúc page

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    // BlocBuilder để listen state changes
  }
}
```