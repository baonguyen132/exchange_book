import 'package:flutter/material.dart';
import '../model/MenuModal.dart';


final List<MenuModal> listmenu = [
    const MenuModal(id: 1, icon: Icons.home, title: "Trang chủ"),
    const MenuModal(id: 2, icon: Icons.book, title: "Sản phẩm"),
    const MenuModal(id: 3, icon: Icons.my_library_books, title: "Sách"),
    const MenuModal(id: 4, icon: Icons.person, title: "Profile"),
    const MenuModal(id: 5, icon: Icons.admin_panel_settings, title: "Admin"),

    const MenuModal(id: 6, icon: Icons.home, title: "Dashboard", status: 1),
    const MenuModal(id: 7, icon: Icons.book, title: "Book" , status: 1),
    const MenuModal(id: 100, icon: Icons.person, title: "Client" , status: 1)
];
