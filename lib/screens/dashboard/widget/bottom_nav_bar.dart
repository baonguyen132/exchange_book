import 'package:exchange_book/screens/dashboard/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

import '../../../data/SideMenuData.dart';
import '../../../model/menu_modal.dart';

class BottomNavBar extends StatefulWidget {
  final DashboardState state;
  final Function(MenuModal item) handle;
  final Function() openDraw;

  const BottomNavBar(
      {super.key,
      required this.handle,
      required this.openDraw,
      required this.state});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<int> menuIndexes = [];

  List<BottomNavigationBarItem> _buildMenuItems(List<int> menuIndexes) {
    final items = <BottomNavigationBarItem>[];

    for (var index in menuIndexes) {
      final menu = listmenu[index];
      final bool isSelected = menu.id == widget.state.indexScreen;

      items.add(BottomNavigationBarItem(
        icon: Tooltip(
          message: menu.title,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 240),
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.onPrimary.withOpacity(0.12)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              menu.icon,
              color: isSelected
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.maintext,
              size: 22,
            ),
          ),
        ),
        label: menu.title,
      ));
    }

    // menu button (last)
    items.add(BottomNavigationBarItem(
      icon: Tooltip(
        message: 'Menu',
        child: Container(
          width: 42,
          height: 42,
          alignment: Alignment.center,
          child: Icon(Icons.menu,
              color: Theme.of(context).colorScheme.maintext, size: 22),
        ),
      ),
      label: 'Menu',
    ));

    return items;
  }

  @override
  Widget build(BuildContext context) {
    // choose which menu indexes to display based on state
    menuIndexes = widget.state.status == 0 ? [0, 1] : [6, 7];

    int validSelectionIndex = menuIndexes
        .indexWhere((i) => listmenu[i].id == widget.state.indexScreen);
    validSelectionIndex = (validSelectionIndex != -1) ? validSelectionIndex : 0;

    final List<BottomNavigationBarItem> items = _buildMenuItems(menuIndexes);

    return SafeArea(
      top: false,
      child: Padding(
        // reduce bottom padding slightly to avoid tiny overflow on some devices
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
        child: Container(
          // slightly smaller height to ensure BottomNavigationBar contents fit
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.mainColor.withOpacity(0.95),
                Theme.of(context).colorScheme.mainColor.withOpacity(0.98),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 6),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: validSelectionIndex,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: Theme.of(context).colorScheme.onPrimary,
              unselectedItemColor: Theme.of(context).colorScheme.maintext,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              selectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
              unselectedLabelStyle: const TextStyle(fontSize: 0),
              onTap: (index) {
                // the last item is always the menu button
                if (index == menuIndexes.length) {
                  widget.openDraw();
                } else {
                  widget.handle(listmenu[menuIndexes[index]]);
                }
              },
              items: items,
              // make bar slightly transparent to blend with gradient container
              landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            ),
          ),
        ),
      ),
    );
  }
}
