# Dashboard Screen

Dashboard chính của ứng dụng. Chia thành 2 phần: Client và Manager.

## Cấu trúc

```
dashboard/
├── page/
│   ├── client/                    # Tính năng người dùng
│   │   ├── home.dart
│   │   ├── product.dart
│   │   ├── profile.dart
│   │   ├── card_detail.dart
│   │   ├── manage_point.dart
│   │   ├── add_point.dart
│   │   ├── assistant.dart
│   │   ├── question.dart
│   │   ├── contribute_ideas.dart
│   │   ├── tranfer_for_user.dart
│   │   ├── cubit/
│   │   └── widget/
│   └── manager/                   # Tính năng admin
│       ├── home_admin.dart
│       ├── book.dart
│       ├── post_facebook.dart
│       ├── cubit/
│       └── widget/
├── cubit/
│   ├── dashboard_cubit.dart
│   ├── dashboard_state.dart
│   └── dashboard_cubit.freezed.dart
└── widget/
    ├── side_menu.dart             # Menu bên trái
    └── top_bar.dart               # Thanh trên
```

## Layout Structure

```
┌─────────────────────────────┐
│        Top Bar              │  (Logo, Search, Notifications, User)
├──────────┬──────────────────┤
│ Side     │                  │
│ Menu     │   Main Content   │
│          │   (Dynamic)      │
└──────────┴──────────────────┘
```

## Navigation

- **Top Bar**: Logo, Search, Notifications, User Menu
- **Side Menu**: Điều hướng đến các tính năng chính
- **Bottom Nav** (Mobile): Navigation trên điện thoại

## Cubit Logic

### dashboard_cubit.dart
**States:**
- `initial` - Trạng thái khởi tạo
- `loading` - Đang tải
- `loaded(User user)` - Đã tải xong
- `pageChanged(String pageName)` - Chuyển trang
- `failure(String message)` - Lỗi

**Methods:**
- `loadUserData()` - Tải thông tin người dùng
- `changePage(String pageName)` - Chuyển trang
- `logout()` - Đăng xuất
- `switchRole(role)` - Chuyển qua vai trò khác (nếu admin)

## Widgets

### side_menu.dart
- Menu điều hướng
- Avatar người dùng
- Logout button

### top_bar.dart
- Logo
- Search bar
- Bell icon notifications
- User menu

## Permission

- Chỉ người đã đăng nhập mới vào được
- Admin có quyền truy cập Manager section

# Client Features

Các tính năng dành cho người dùng thường.

## Cấu trúc

```
client/
├── home.dart                       # Trang chủ
├── product.dart                    # Danh sách sách
├── profile.dart                    # Hồ sơ người dùng
├── card_detail.dart                # Chi tiết sách
├── manage_point.dart               # Quản lý điểm
├── add_point.dart                  # Nạp điểm
├── assistant.dart                  # Trợ lý AI
├── question.dart                   # Quiz
├── contribute_ideas.dart           # Đóng góp ý kiến
├── tranfer_for_user.dart           # Chuyển điểm
├── cubit/
│   ├── home_cubit.dart
│   ├── product_cubit.dart
│   ├── profile_cubit.dart
│   ├── cart_cubit.dart
│   ├── point_cubit.dart
│   ├── assistant_cubit.dart
│   ├── question_cubit.dart
│   └── [state files]
└── widget/
    ├── book_card.dart
    ├── point_card.dart
    ├── featured_section.dart
    └── ...
```

## Các Features

### home.dart
**Hiển thị:**
- Sách nổi bật (featured)
- Sách mới nhất
- Danh mục sách
- Quick access buttons
- User greeting

**Cubit:** `home_cubit.dart`

### product.dart
**Hiển thị:**
- Danh sách sách với filter/sort
- Search bar
- Category filter
- Price range filter
- Pagination

**Cubit:** `product_cubit.dart`

### card_detail.dart
**Hiển thị:**
- Ảnh sách
- Tên, tác giả, giá
- Mô tả chi tiết
- Đánh giá, bình luận
- Nút thêm vào giỏ
- Nút mua ngay

**Cubit:** `product_cubit.dart` hoặc `cart_cubit.dart`

### profile.dart
**Hiển thị:**
- Avatar người dùng
- Tên, email, phone
- Địa chỉ
- Lịch sử mua hàng
- Settings

**Cubit:** `profile_cubit.dart`

### manage_point.dart
**Hiển thị:**
- Số điểm hiện tại
- Lịch sử giao dịch
- Cách kiếm điểm
- Điểm có thể đổi

**Cubit:** `point_cubit.dart`

### add_point.dart
**Hiển thị:**
- Form nạp điểm
- Phương thức thanh toán
- Lịch sử nạp

**Cubit:** `point_cubit.dart`

### tranfer_for_user.dart
**Hiển thị:**
- Form tìm người nhận
- Nhập số điểm chuyển
- Xác nhận giao dịch

**Cubit:** `point_cubit.dart`

### assistant.dart
**Hiển thị:**
- Chat với AI
- Lịch sử hội thoại
- Suggested questions

**Cubit:** `assistant_cubit.dart`

### question.dart
**Hiển thị:**
- Quiz questions
- Timer
- Score
- Leaderboard

**Cubit:** `question_cubit.dart`

### contribute_ideas.dart
**Hiển thị:**
- Form đóng góp sách/ý kiến
- Upload ảnh
- Danh sách đóng góp của tôi

**Cubit:** Có cubit riêng hoặc dùng lại

## Widget Components

### book_card.dart
Card hiển thị sách với ảnh, tên, giá

### point_card.dart
Card hiển thị số điểm hiện tại

### featured_section.dart
Section sách nổi bật

### filter_widget.dart
Widget filter/sort sách

## Route Names

```dart
'/dashboard/home'
'/dashboard/product'
'/dashboard/product/:id'
'/dashboard/profile'
'/dashboard/manage_point'
'/dashboard/add_point'
'/dashboard/transfer'
'/dashboard/assistant'
'/dashboard/quiz'
'/dashboard/contribute'
```