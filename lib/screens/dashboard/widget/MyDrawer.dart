import 'package:flutter/material.dart';
import 'package:project_admin/theme/theme.dart';

import '../../../data/SideMenuData.dart';
import '../../../model/MenuModal.dart';
import '../../../model/UserModal.dart';
import 'dark_light_mode.dart';
import 'side_menu_widget.dart';

class Mydrawer extends StatefulWidget {

  int selection ;
  int status ;
  bool isDesktop ;

  final Function (MenuModal item) handle ;

  Mydrawer({super.key , required this.selection , required this.handle , required this.status , this.isDesktop = false});

  @override
  State<Mydrawer> createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  UserModel? user ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initLoadData() ;
  }

  Future<void> initLoadData() async {
    UserModel? loadedUser = await UserModel.loadUserData(); // Chờ dữ liệu trước
    setState(() {
      if(loadedUser != null) {
        user = loadedUser;
      }

    });
  }

  Widget _buildMenuItem(int index) {
    return SideMenuWidget(
      item: listmenu.elementAt(index),
      isSelected: widget.selection,
      ontap: () {
        setState(() {
          widget.selection = listmenu.elementAt(index).id;
          widget.handle(listmenu.elementAt(index));
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color main_color = Theme.of(context).colorScheme.mainColor ;


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
              Container(
                height: MediaQuery.of(context).size.height*0.8,
                child: ListView(
                  children: [
                    Container(
                      height: 100,
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite_outlined,
                            size: 30,
                            color: main_color,

                          ),
                          Container(
                            padding: EdgeInsets.only(top: 15, bottom: 15 ,left: 15),
                            child: Text(
                              "Project one",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,

                                color: main_color
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    widget.status == 0
                        ? Column(
                      children: [
                        if(widget.isDesktop) ...[
                          _buildMenuItem(0),
                          _buildMenuItem(1)
                        ],
                        if (user != null) ...[
                          _buildMenuItem(2),
                          _buildMenuItem(3),
                          if (user?.status == "5") _buildMenuItem(4),
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
              Container(
                  height: MediaQuery.of(context).size.height*0.2,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const DarkLightMode() ,
                          Container(
                            margin: EdgeInsets.all(10),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  if(user == null) {
                                  }
                                  else {
                                    UserModel.removeUserData() ;
                                  }
                                  Navigator.pushReplacementNamed(context, "/login") ;
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(13),
                                      child: Icon(
                                        user == null ? Icons.login :Icons.logout  ,
                                        color: Theme.of(context).colorScheme.maintext,
                                      ),
                                    ),
                                    Text(
                                      user == null ?  "Log in" : "Log out" ,
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

