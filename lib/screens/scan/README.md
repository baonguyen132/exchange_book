# Scan QR Code Screen

Màn hình quét mã QR code sách.

## Cấu trúc

```
scan/
├── scan_qr_code.dart       # Màn hình quét
├── scan_result.dart        # Kết quả quét
├── cubit/
│   ├── scan_cubit.dart
│   ├── scan_state.dart
│   └── scan_cubit.freezed.dart
└── widget/
    ├── camera_overlay.dart
    ├── scan_button.dart
    └── scan_history.dart
```

## Các file

### scan_qr_code.dart
- Giao diện camera để quét QR
- Overlay hướng dẫn quét
- Hiển thị preview camera

### scan_result.dart
- Hiển thị kết quả sau khi quét
- Thông tin sách từ QR code
- Nút thêm vào giỏ hàng

### widget/

#### camera_overlay.dart
- Vẽ overlay hướng dẫn trên camera
- Khung quét (frame)
- Text hướng dẫn

#### scan_button.dart
- Nút quét manual
- Nút chọn từ thư viện

#### scan_history.dart
- Danh sách các sách đã quét
- Thời gian quét

## Cubit Logic

### scan_cubit.dart
**States:**
- `initial` - Trạng thái khởi tạo
- `scanning` - Đang quét
- `scanned(QRCode result)` - Quét thành công
- `processing` - Đang xử lý dữ liệu
- `bookFound(Book book)` - Tìm thấy sách
- `bookNotFound` - Không tìm thấy sách
- `failure(String message)` - Quét thất bại

**Methods:**
- `startScanning()` - Bắt đầu quét
- `stopScanning()` - Dừng quét
- `processScanResult(result)` - Xử lý kết quả
- `getBookByQRCode(qrCode)` - Lấy sách từ QR
- `getScanHistory()` - Lấy lịch sử quét

## Permissions

📱 Yêu cầu:
- `CAMERA` - Truy cập camera
- Xử lý permission request trên Android/iOS

## Features

✅ Quét QR code sách
✅ Hiển thị thông tin sách
✅ Thêm vào giỏ hàng từ kết quả
✅ Lịch sử quét
✅ Share kết quả

## Navigation

- ✅ Quét thành công → Book detail / Add to cart
- 🔗 Quay lại → Dashboard