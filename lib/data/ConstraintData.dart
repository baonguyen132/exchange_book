var mainPage = 1 ;
var mainLightDarkMode = true ;

final location = "https://de46-2405-4802-b550-96a0-1856-563c-7ae8-990e.ngrok-free.app" ;


// Hàm chuyển số CCCD thành ngày tháng năm
String formatIDToDate(String idNumber) {
  if (idNumber.length != 8) return "Invalid"; // Kiểm tra hợp lệ

  String day = idNumber.substring(0, 2);  // "13"
  String month = idNumber.substring(2, 4); // "02"
  String year = idNumber.substring(4, 8);  // "2004"

  return "$year-$month-$day"; // Trả về định dạng YYYY-MM-DD
}