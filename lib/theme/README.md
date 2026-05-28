# Theme Directory

Quản lý Design System - Màu sắc, Typography, Styles toàn ứng dụng.

## Các file

### theme.dart
Định nghĩa toàn bộ theme của ứng dụng

**Bao gồm:**
- **Colors** - Bảng màu chính (primary, secondary, background, error...)
- **Typography** - Font, text styles
- **ThemeData** - Light theme & dark theme
- **Border Radius** - Kích thước bo tròn
- **Spacing** - Khoảng cách padding/margin

## Ví dụ sử dụng

```dart
import 'package:exchange_book/theme/theme.dart';

// Màu sắc
Color primary = AppColors.primary;
Color error = AppColors.error;

// Text style
TextStyle headline = AppTheme.headline;
TextStyle bodyText = AppTheme.bodyText;

// Theme Material
ThemeData theme = AppTheme.lightTheme;
```

## Cấu trúc theme

```dart
class AppColors {
  static const Color primary = Color(0xFF6366F1);
  static const Color secondary = Color(0xFF8B5CF6);
  static const Color error = Color(0xFFDC2626);
  static const Color background = Color(0xFFFAFAFA);
}

class AppTheme {
  static const TextStyle headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
}
```

## Quy tắc

- Không hardcode màu sắc trong widget, sử dụng theme
- Maintain consistency giữa light/dark mode
- Tập trung tất cả style ở đây