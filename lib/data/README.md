# Data Directory

Thư mục này chứa các dữ liệu tĩnh, hằng số, và cấu hình toàn cục của ứng dụng.

## Các file

### ConstraintData.dart
- Chứa các **hằng số toàn cục** (API endpoints, timeout, pagination size)
- Các **hàm utility** dùng chung (format tiền, ngày tháng, validate input)
- Cấu hình **API base URL** và headers

### SideMenuData.dart
- Dữ liệu menu điều hướng cho sidebar
- Định nghĩa các mục menu với icon và route

## Quy tắc sử dụng

```dart
import 'package:exchange_book/data/ConstraintData.dart';

// Sử dụng hằng số
final url = ConstraintData.apiBaseUrl;

// Sử dụng hàm utility
String formatted = ConstraintData.formatCurrency(10000);
```