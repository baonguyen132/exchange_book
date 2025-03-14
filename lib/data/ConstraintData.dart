var mainLightDarkMode = true ;

// final location = "https://2d33-2405-4802-60be-8cd0-3858-f9df-d7e6-6263.ngrok-free.app" ;
final location = "http://localhost:5000/" ;


// Hàm chuyển số CCCD thành ngày tháng năm
String formatIDToDate(String idNumber) {
  if (idNumber.length != 8) return "Invalid"; // Kiểm tra hợp lệ

  String day = idNumber.substring(0, 2);  // "13"
  String month = idNumber.substring(2, 4); // "02"
  String year = idNumber.substring(4, 8);  // "2004"

  return "$year-$month-$day"; // Trả về định dạng YYYY-MM-DD
}