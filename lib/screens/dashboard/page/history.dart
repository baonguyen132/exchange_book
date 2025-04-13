import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/widget_sign_up_book.dart';

import '../../../model/UserModal.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  bool state = true ;
  UserModel? user ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();

  }
  loadData() async {
    user = await UserModel.loadUserData() ;
  }

  Widget getWidget() {
    return state ? Container(color: Colors.blue,) : WidgetSignUpBook(user: user!,) ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Padding(padding: EdgeInsets.all(20), child: getWidget(),),),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
        child: Icon(Icons.add , size: 25,),
        onPressed: () {
          setState(() {
            state = !state ;
          });
        },
      ),
    );
  }
}
