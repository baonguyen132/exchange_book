import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:exchange_book/screens/dashboard/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

import '../../../data/SideMenuData.dart';
import '../../../model/menu_modal.dart';

class BottomNavBar extends StatefulWidget {
  final DashboardState state ;
  final Function(MenuModal item) handle;
  final Function() openDraw ;

  const BottomNavBar({
    super.key,
    required this.handle,
    required this.openDraw, required this.state
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  List<int> menuIndexes = [];


  List<Widget> _buildMenuItems() {
    if (widget.state.status == 0) {
      menuIndexes = [0, 1];
    } else {
      menuIndexes = [5, 6];
    }

    List<Widget> list =  menuIndexes.map((index) {
      return Icon(
        listmenu[index].icon,
        size: 30,
        color: listmenu[index].id == widget.state.indexScreen
            ? Colors.white
            : Theme.of(context).colorScheme.maintext,
      );
    }).toList();
    list.add(Icon(Icons.menu , color: Theme.of(context).colorScheme.maintext));
    return list ;
  }

  @override
  Widget build(BuildContext context) {
    int validSelectionIndex = menuIndexes.indexWhere((i) => listmenu[i].id == widget.state.indexScreen);
    validSelectionIndex = (validSelectionIndex != -1) ? validSelectionIndex : 0;

    return CurvedNavigationBar(
      index: validSelectionIndex,
      backgroundColor: Colors.transparent, // nền phía sau (phần body)
      color: Theme.of(context).colorScheme.mainColor , // màu thanh nav
      buttonBackgroundColor: Theme.of(context).colorScheme.mainColor, // màu nút được chọn
      animationDuration: const Duration(milliseconds: 300),
      height: 60,
      items: _buildMenuItems(),
      onTap: (index) {
        if(index == 2) {
          widget.openDraw() ;
        }
        else {
          widget.handle(listmenu[menuIndexes[index]]);
        }
      },
    );
  }
}
