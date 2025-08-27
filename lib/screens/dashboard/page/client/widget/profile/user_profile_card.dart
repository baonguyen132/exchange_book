import 'package:exchange_book/screens/dashboard/page/client/widget/profile/user_profile_card_img.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/profile/user_profile_card_information.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/model/user_modal.dart';
import 'package:exchange_book/theme/theme.dart';

class UserProfileCard extends StatefulWidget {
  final bool isMobile  ;
  final UserModel userModel ;
  const UserProfileCard({super.key , this.isMobile = false , required this.userModel});

  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {

  @override
  Widget build(BuildContext context) {
    final backgroundBoxDecoration = BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: Theme.of(context).colorScheme.mainCard,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1), // Màu bóng
          blurRadius: 10, // Độ mờ của bóng
          spreadRadius: 2, // Độ lan rộng của bóng
          offset: const Offset(0, 4), // Vị trí bóng (x, y)
        ),
      ],
    ) ;

    return !widget.isMobile ? Container(
      width: MediaQuery.of(context).size.width,
      decoration: backgroundBoxDecoration ,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 300,
              child: UserProfileCardImg(isMobile: widget.isMobile,userModel: widget.userModel,),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(30),
                child: UserProfileCardInformation(user: widget.userModel,)
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
          SizedBox(
            height: 400,
            child: UserProfileCardImg(
              isMobile: widget.isMobile,
              userModel: widget.userModel
            ),
          ),
          Container(
            margin: const EdgeInsets.all(30),
            alignment: Alignment.topLeft,
            child: UserProfileCardInformation(user: widget.userModel)
          )

        ],
      ),
    ) ;
  }
}
