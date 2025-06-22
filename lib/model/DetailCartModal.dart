import 'dart:convert';

import 'package:exchange_book/model/BookModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailCartModal {
  BookModal bookModal ;
  String name_book ;
  int quantity;
  int id_cart  ;

  DetailCartModal({
    required this.bookModal,
    required this.name_book,
    required this.quantity,
    this.id_cart = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      "bookModal": bookModal.toJson(),
      "quantity": quantity,
      "id_cart": id_cart,
      "name_book": name_book
    };
  }
  factory DetailCartModal.fromJson(Map<String, dynamic> json) {
    return DetailCartModal(
      bookModal: BookModal.fromJson(json['bookModal']),
      quantity: json['quantity'],
      id_cart: json['id_cart'],
      name_book: json['name_book']
    );
  }

  static Future<void> saveDetail(String idItem, String idSeller ,  DetailCartModal detailCartModal) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String>? list = await loadData();

    list ??= {};

    // Nếu đã có dữ liệu của người bán
    if (list.containsKey(idSeller)) {
      // Parse dữ liệu người bán thành Map<String, dynamic>
      Map<String, dynamic> exportListRaw = jsonDecode(list[idSeller]!);

      // Convert sang Map<String, String>
      Map<String, String> exportList = exportListRaw.map((key, value) => MapEntry(key, value.toString()));

      if (exportList.containsKey(idItem)) {
        DetailCartModal existingItem = DetailCartModal.fromJson(jsonDecode(exportList[idItem]!));
        existingItem.quantity += detailCartModal.quantity;
        exportList[idItem] = jsonEncode(existingItem.toJson());
      } else {
        exportList[idItem] = jsonEncode(detailCartModal.toJson());
      }

      list[idSeller] = jsonEncode(exportList);
    } else {
      // Tạo mới giỏ hàng cho người bán
      Map<String, String> exportList = {
        idItem: jsonEncode(detailCartModal.toJson())
      };
      list[idSeller] = jsonEncode(exportList);
    }
    await preferences.setString("data_cart", jsonEncode(list));
  }
  static Future<void> deleteItem(String idItem, String idSeller) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String>? list = await loadData();

    list ??= {};

    if (list.containsKey(idSeller)) {
      Map<String, dynamic> exportListRaw = jsonDecode(list[idSeller]!);
      Map<String, String> exportList = exportListRaw.map((key, value) => MapEntry(key, value.toString()));

      // Xoá sản phẩm
      exportList.remove(idItem);

      // Nếu còn item thì update lại list[idSeller], nếu không thì xoá cả seller
      if (exportList.isNotEmpty) {
        list[idSeller] = jsonEncode(exportList);
      } else {
        list.remove(idSeller);
      }

      await preferences.setString("data_cart", jsonEncode(list));
    }
  }

  static Future<void> updateItem(String idItem, String idSeller, int newQuantity) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String>? list = await loadData();

    list ??= {};

    if (list.containsKey(idSeller)) {
      Map<String, dynamic> exportListRaw = jsonDecode(list[idSeller]!);
      Map<String, String> exportList = exportListRaw.map((key, value) => MapEntry(key, value.toString()));

      if (exportList.containsKey(idItem)) {
        DetailCartModal existingItem = DetailCartModal.fromJson(jsonDecode(exportList[idItem]!));
        existingItem.quantity = newQuantity;
        exportList[idItem] = jsonEncode(existingItem.toJson());

        list[idSeller] = jsonEncode(exportList);
        await preferences.setString("data_cart", jsonEncode(list));
      }
    }
  }


  static Future<Map<String, String>?> loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonString = preferences.getString("data_cart");

    if (jsonString != null) {
      try {
        Map<String, String> jsonData = Map<String, dynamic>.from(jsonDecode(jsonString))
            .map((key, value) => MapEntry(key, value as String));
        return jsonData;
      } catch (e) {
        print("Lỗi khi parse JSON: $e");
        return null;
      }
    }
    return null;
  }
  static Future<void> removeDetailCartData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("data_cart"); // Xóa dữ liệu user
    print("Dữ liệu đã bị xoá!");
  }

}