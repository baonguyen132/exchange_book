import 'dart:math';

import 'package:exchange_book/screens/dashboard/page/client/widget/profile/introduce_profile.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/profile/product_profile.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/profile/user_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

import '../../../../model/BookModal.dart';
import '../../../../model/UserModal.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<dynamic>? list ;
  UserModel user = UserModel(id: '', name: '', email: '', password: '', cccd: '', dob: '', gender: '', address: '',point: '' ,token: '');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initLoadData() ;
  }

  Future<void> initLoadData() async {
    UserModel? loadedUser = await UserModel.loadUserData(); // Chờ dữ liệu trước
    List<dynamic> data = await BookModal.exporUserBook(loadedUser!.id.toString());
    setState(() {
      user = loadedUser;
      list=data ;
    });
  }

  Widget getLayout(double width) {
    if(width < 1000 && width >=650) {
      return Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            UserProfileCard(userModel: user,),
            SizedBox(height: 30,),
            IntroduceProfile(height: 400, weight: MediaQuery.of(context).size.width , margin: 0,),
            SizedBox(height: 30,),
            list != null ?  ProductProfile(list: list!,) : Container()
          ],
        ),
      ) ;
    }
    else if(width < 650) {
      return Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            UserProfileCard(ismobile: true, userModel: user,),
            SizedBox(height: 10,),
            IntroduceProfile(height: 400, weight: MediaQuery.of(context).size.width , margin: 0,),
            SizedBox(height: 10,),
            list != null ?  ProductProfile(list: list!,) : Container()
          ],
        ),
      );
    }
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10 , top: 10 , bottom: 10),
                child: Column(
                  children: [
                    UserProfileCard(userModel: user,),
                    SizedBox(height: 10,),
                    list != null ?  ProductProfile(list: list!,) : Container()
                  ],
                ),
              )
          ),
          IntroduceProfile(weight: max(300 , MediaQuery.of(context).size.width*0.22) , margin: 10,)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ListView(
      children: [
        getLayout(width),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 400,
          margin: EdgeInsets.only(left: 10 , right: 10 , bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).colorScheme.mainCard,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Màu bóng
                blurRadius: 10, // Độ mờ của bóng
                spreadRadius: 2, // Độ lan rộng của bóng
                offset: Offset(0, 4), // Vị trí bóng (x, y)
              ),
            ],
          ),
        )
      ],
    );
  }
}
