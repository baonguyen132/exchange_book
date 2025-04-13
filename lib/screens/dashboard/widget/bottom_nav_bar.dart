import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_admin/theme/theme.dart';

import '../../../data/SideMenuData.dart';
import '../../../model/MenuModal.dart';
import '../../../model/UserModal.dart';

class BottomNavBar extends StatefulWidget {
  int selection;
  int status;

  final Function(MenuModal item) handle;
  final Function() openDraw ;
  BottomNavBar({
    super.key,
    required this.selection,
    required this.status,
    required this.handle,
    required this.openDraw
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

  List<Widget> _buildMenuItems() {
    if (widget.status == 0) {
      menuIndexes = [0, 1];
    } else {
      menuIndexes = [5, 6];
    }

    List<Widget> list =  menuIndexes.map((index) {
      return Icon(
        listmenu[index].icon,
        size: 30,
        color: listmenu[index].id == widget.selection
            ? Colors.white
            : Theme.of(context).colorScheme.maintext,
      );
    }).toList();
    list.add(Icon(Icons.menu , color: Theme.of(context).colorScheme.maintext));
    return list ;
  }

  @override
  Widget build(BuildContext context) {
    int validSelectionIndex = menuIndexes.indexWhere((i) => listmenu[i].id == widget.selection);
    validSelectionIndex = (validSelectionIndex != -1) ? validSelectionIndex : 0;

    return CurvedNavigationBar(
      index: validSelectionIndex,
      backgroundColor: Colors.transparent, // nền phía sau (phần body)
      color: Theme.of(context).colorScheme.mainColor , // màu thanh nav
      buttonBackgroundColor: Theme.of(context).colorScheme.mainColor, // màu nút được chọn
      animationDuration: Duration(milliseconds: 300),
      height: 60,
      items: _buildMenuItems(),
      onTap: (index) {
        if(index == 2) {
          widget.openDraw() ;
        }
        else {
          setState(() {
            widget.selection = listmenu[menuIndexes[index]].id;
            widget.handle(listmenu[menuIndexes[index]]);
          });

        }
      },
    );
  }
}
