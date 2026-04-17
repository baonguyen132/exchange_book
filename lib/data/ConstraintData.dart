import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

var mainLightDarkMode = true ;

const location = "https://steady-sharply-ibex.ngrok-free.app" ;
// const location = "http://localhost:5000" ;
const apiAI = "https://7c17-2001-ee0-4b4e-5f80-5c27-ddf5-cdd5-24b3.ngrok-free.app/webhook/bookswap" ;

// Hàm chuyển số CCCD thành ngày tháng năm
String formatIDToDate(String idNumber) {
  if (idNumber.length != 8) return "Invalid"; // Kiểm tra hợp lệ

  String day = idNumber.substring(0, 2);  // "13"
  String month = idNumber.substring(2, 4); // "02"
  String year = idNumber.substring(4, 8);  // "2004"

  return "$year-$month-$day"; // Trả về định dạng YYYY-MM-DD
}

void toast(String content) {
  Fluttertoast.showToast(
    msg: content,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black54,
    textColor: Colors.white,
    fontSize: 16.0,
  );
} 