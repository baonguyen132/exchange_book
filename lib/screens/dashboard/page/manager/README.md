# filepath: d:\VKU\Flutter\exchange_book\lib\screens\dashboard\page\manager\README.md
# Manager/Admin Features

Các tính năng dành cho quản trị viên.

## Cấu trúc

```
manager/
├── home_admin.dart                 # Dashboard admin
├── book.dart                       # Quản lý sách
├── post_facebook.dart              # Đăng Facebook
├── cubit/
│   ├── admin_cubit.dart
│   ├── book_cubit.dart
│   ├── facebook_cubit.dart
│   └── [state files]
└── widget/
    ├── admin_stats_card.dart
    ├── book_table.dart
    ├── user_analytics.dart
    └── ...
```

## Các Features

### home_admin.dart
**Dashboard với:**
- Thống kê tổng quan (Total users, books, revenue, transactions)
- Chart doanh thu theo ngày/tháng
- Top books bán chạy
- Recent transactions
- User statistics
- Quick actions

**Cubit:** `admin_cubit.dart`

**Hiển thị:**
```
┌─────────────┬─────────────┬─────────────┬─────────────┐
│   Users     │   Books     │  Revenue    │ Transactions│
├─────────────┴─────────────┴─────────────┴─────────────┤
│         Revenue Chart (Line/Bar)                      │
├──────────────────────────────────────────────────────┤
│  Top Books          │   Recent Transactions           │
│  1. Book A (100)    │   User1 → 50 points             │
│  2. Book B (80)     │   User2 bought Book C           │
│  3. Book C (60)     │   User3 transferred points      │
└──────────────────────────────────────────────────────┘
```

### book.dart
**Quản lý sách:**
- Danh sách sách (table view)
- Add book (form)
- Edit book
- Delete book
- Bulk upload (CSV/Excel)
- Export danh sách

**Cubit:** `book_cubit.dart`

**CRUD Operations:**
- `addBook(bookData)` - Thêm sách mới
- `updateBook(id, bookData)` - Cập nhật
- `deleteBook(id)` - Xóa
- `getBooks()` - Lấy danh sách
- `searchBooks(query)` - Tìm kiếm
- `bulkUpload(file)` - Upload hàng loạt

**Form Fields:**
- Title (Tiêu đề)
- Author (Tác giả)
- Category (Danh mục)
- Price (Giá)
- Stock (Kho)
- Description (Mô tả)
- Image (Ảnh)
- QR Code (Generate tự động hoặc upload)

### post_facebook.dart
**Đăng bài Facebook:**
- Compose post
- Upload ảnh/video
- Select page (page nào)
- Schedule post
- Preview post
- Analytics (like, share, comment count)

**Cubit:** `facebook_cubit.dart`

**Methods:**
- `postToFacebook(content, image, page)` - Đăng bài
- `schedulePost(content, image, dateTime)` - Lên lịch
- `getPostAnalytics(postId)` - Xem analytics
- `getPages()` - Lấy danh sách pages

**Features:**
- Auto-generate post từ top books
- Template posts
- Draft posts
- Edit/delete posted content

## Widget Components

### admin_stats_card.dart
Card hiển thị thống kê (số người dùng, doanh thu, v.v)

### book_table.dart
Table hiển thị danh sách sách với action (edit, delete)

### user_analytics.dart
Chart phân tích người dùng

### sales_chart.dart
Chart doanh thu theo thời gian

## Permission

✅ Chỉ admin/manager mới vào được
✅ Log tất cả actions (add, edit, delete)

## Route Names

```dart
'/dashboard/admin'
'/dashboard/admin/books'
'/dashboard/admin/books/add'
'/dashboard/admin/books/:id/edit'
'/dashboard/admin/facebook'
'/dashboard/admin/analytics'
```

## Database/API

**Endpoints cần:**
- GET `/admin/stats` - Thống kê
- GET `/admin/books` - Danh sách sách
- POST `/admin/books` - Thêm sách
- PUT `/admin/books/:id` - Cập nhật
- DELETE `/admin/books/:id` - Xóa
- POST `/admin/facebook/post` - Đăng Facebook
- GET `/admin/facebook/pages` - Danh sách pages