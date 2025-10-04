import 'package:exchange_book/screens/dashboard/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

import '../../../data/SideMenuData.dart';
import '../../../model/menu_modal.dart';
import '../../../model/user_modal.dart';
import 'dark_light_mode.dart';
import 'side_menu_widget.dart';

class MyDrawer extends StatefulWidget {

  final DashboardState state ;
  final bool isDesktop ;

  final Function (MenuModal item) handle ;

  const MyDrawer({
    super.key ,
    required this.state,
    required this.handle ,
    this.isDesktop = false,

  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {


  Widget _buildMenuItem(int index) {
    return SideMenuWidget(
      item: listmenu.elementAt(index),
      isSelected: widget.state.indexScreen,
      ontap: () {widget.handle(listmenu.elementAt(index));},
    );
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor = Theme.of(context).colorScheme.mainColor ;


    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.mainCard,
      elevation: 8.0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight:Radius.circular(8),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(8)
          )
      ),
      shadowColor: Theme.of(context).colorScheme.shadow,
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.8,
                child: ListView(
                  children: [
                    Container(
                      height: 100,
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite_outlined,
                            size: 30,
                            color: mainColor,

                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 15, bottom: 15 ,left: 15),
                            child: Text(
                              "Book Swap",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,

                                color: mainColor
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    widget.state.status == 0
                        ? Column(
                      children: [
                        if(widget.isDesktop) ...[
                          _buildMenuItem(0),
                          _buildMenuItem(1)
                        ],
                        if (widget.state.user.id != "0") ...[
                          _buildMenuItem(2),
                          _buildMenuItem(3),
                          if (widget.state.user.status == "5") _buildMenuItem(4),
                        ],
                      ],
                    )
                        : Column(
                      children: [
                        if(widget.isDesktop) ...[
                          _buildMenuItem(5),
                          _buildMenuItem(6),
                        ],
                        _buildMenuItem(7),
                        _buildMenuItem(8),
                      ],
                    ),
                  ],
                ),

              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height*0.2,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const DarkLightMode() ,
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  if(widget.state.user.id != "0") {UserModel.removeUserData() ;}
                                  Navigator.pushReplacementNamed(context, "/login") ;
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(13),
                                      child: Icon(
                                        widget.state.user.id == "0"  ? Icons.login :Icons.logout  ,
                                        color: Theme.of(context).colorScheme.maintext,
                                      ),
                                    ),
                                    Text(
                                      widget.state.user.id == "0" ?  "Log in" : "Log out" ,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context).colorScheme.maintext
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}

