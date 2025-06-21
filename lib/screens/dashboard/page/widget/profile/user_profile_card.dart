import 'package:flutter/material.dart';
import 'package:exchange_book/model/UserModal.dart';
import 'package:exchange_book/screens/dashboard/page/widget/profile/user_profile_card_img.dart';
import 'package:exchange_book/screens/dashboard/page/widget/profile/user_profile_card_infor.dart';
import 'package:exchange_book/theme/theme.dart';

class UserProfileCard extends StatefulWidget {
  bool ismobile  ;
  UserModel userModel ;
  UserProfileCard({super.key , this.ismobile = false , required this.userModel});

  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {

  @override
  Widget build(BuildContext context) {
    final backgroundBoxDecoration = BoxDecoration(
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
    ) ;

    return !widget.ismobile ? Container(
      width: MediaQuery.of(context).size.width,
      decoration: backgroundBoxDecoration ,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 300,
              child: UserProfileCardImg(isMobile: widget.ismobile,userModel: widget.userModel,),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(30),
                child: UserProfileCardInfor(user: widget.userModel,)
              ),
            )
          ],
        ),
      ),
    ):
    Container(
      decoration: backgroundBoxDecoration,
      child: Column(
        children: [
          Container(
            height: 400,
            child: UserProfileCardImg(
              isMobile: widget.ismobile,
              userModel: widget.userModel
            ),
          ),
          Container(
            margin: EdgeInsets.all(30),
            alignment: Alignment.topLeft,
            child: UserProfileCardInfor(user: widget.userModel)
          )

        ],
      ),
    ) ;
  }
}
