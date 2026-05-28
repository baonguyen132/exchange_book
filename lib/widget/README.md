# Widget Directory

Chứa các component UI tái sử dụng dùng chung toàn ứng dụng.

## Cấu trúc

```
widget/
├── card/               # Các loại card
│   ├── card_item_image.dart
│   ├── card_item_text.dart
│   └── card_header.dart
├── MyDrawer.dart       # Navigation drawer
├── BottomNavBar.dart   # Bottom navigation
├── AppBar.dart         # Custom app bar
├── Button.dart         # Custom buttons
└── ...
```

## Các widget chính

### card/card_item_image.dart
Card hiển thị sản phẩm với ảnh

```dart
CardItemImage(
  imageUrl: 'https://...',
  title: 'Tên sách',
  price: 50000,
  onTap: () {},
)
```

### MyDrawer.dart
Navigation drawer chứa menu chính

### BottomNavBar.dart
Bottom navigation bar để chuyển trang

### AppBar.dart
Custom app bar với logo và action buttons

## Quy tắc

- Widget phải **stateless** trừ khi cần state
- Sử dụng **composition** thay vì inheritance
- Props phải có **default values**
- Widget có `required` parameters phải khai báo rõ
- Thêm comments cho complex widgets

## Ví dụ custom widget

```dart
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  const CustomButton({
    required this.label,
    required this.onPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.blue,
      ),
      child: Text(label),
    );
  }
}
```