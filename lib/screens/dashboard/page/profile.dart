import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/widget/profile/introduce_profile.dart';
import 'package:project_admin/screens/dashboard/page/widget/profile/product_profile.dart';
import 'package:project_admin/screens/dashboard/page/widget/profile/user_profile_card.dart';
import 'package:project_admin/theme/theme.dart';

import '../../../model/UserModal.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserModel user = UserModel(id: '', name: '', email: '', password: '', cccd: '', dob: '', gender: '', address: '', token: '');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initLoadData() ;
  }

  Future<void> initLoadData() async {
    UserModel? loadedUser = await UserModel.loadUserData(); // Chờ dữ liệu trước
    setState(() {
      user = loadedUser!;
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
            ProductProfile()
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
            ProductProfile()
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
                    ProductProfile()
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
