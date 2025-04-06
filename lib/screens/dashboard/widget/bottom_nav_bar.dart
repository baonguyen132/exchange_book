import 'package:flutter/material.dart';
import 'package:project_admin/theme/theme.dart';

import '../../../data/SideMenuData.dart';
import '../../../model/MenuModal.dart';
import '../../../model/UserModal.dart';

class BottomNavBar extends StatefulWidget {
  int selection;
  int status;

  final Function(MenuModal item) handle;

  BottomNavBar({
    super.key,
    required this.selection,
    required this.status,
    required this.handle,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  UserModel? user;
  List<int> menuIndexes = [];

  @override
  void initState() {
    super.initState();
    initLoadData();
  }

  Future<void> initLoadData() async {
    UserModel? loadedUser = await UserModel.loadUserData();
    setState(() {
      user = loadedUser;
    });
  }

  List<BottomNavigationBarItem> _buildMenuItems() {
    // Dựa vào status và trạng thái user, ta sẽ quyết định số lượng item cho navigation bar
    if (widget.status == 0) {
      menuIndexes = [0, 1]; // 2 item cơ bản
      if (user != null) {
        menuIndexes.addAll([2, 3]); // Thêm 2 item nếu có user
        if (user?.status == "5") {
          menuIndexes.add(4); // Thêm item đặc biệt nếu user có quyền admin
        }
      }
    } else {
      menuIndexes = [5, 6, 7]; // 3 item cho status khác 0
    }

    return menuIndexes.map((index) {
      return BottomNavigationBarItem(
        icon: Icon(listmenu[index].icon),
        label: listmenu[index].title,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Xử lý trường hợp nếu widget.selection không hợp lệ
    int validSelectionIndex = menuIndexes.indexWhere((i) => listmenu[i].id == widget.selection);
    // Nếu widget.selection không hợp lệ, chọn index mặc định là 0
    validSelectionIndex = (validSelectionIndex != -1) ? validSelectionIndex : 0;

    return BottomNavigationBar(
      currentIndex: validSelectionIndex,
      onTap: (index) {
        setState(() {
          widget.selection = listmenu[menuIndexes[index]].id;
          widget.handle(listmenu[menuIndexes[index]]);
        });
      },
      items: _buildMenuItems(),
      backgroundColor: Theme.of(context).colorScheme.mainCard,  // Đặt màu nền
      selectedItemColor: Theme.of(context).colorScheme.mainColor,  // Màu khi chọn item
      unselectedItemColor: Theme.of(context).colorScheme.maintext,  // Màu khi không chọn item
    );
  }
}
