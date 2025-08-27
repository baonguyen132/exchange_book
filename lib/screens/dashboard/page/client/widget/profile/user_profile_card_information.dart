import 'package:flutter/material.dart';
import 'package:exchange_book/model/user_modal.dart';
import 'package:exchange_book/theme/theme.dart';

class UserProfileCardInformation extends StatefulWidget {
  final UserModel user ;
  const UserProfileCardInformation({super.key , required this.user});

  @override
  State<UserProfileCardInformation> createState() => _UserProfileCardInformationState();
}

class _UserProfileCardInformationState extends State<UserProfileCardInformation> {

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.user.name,
          style: const TextStyle(
              fontSize: 22,
              color: Colors.blue,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 20,) ,
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            Text(
              "Point: ${widget.user.point}",
              style: TextStyle(
                fontSize: 22,
                color: Theme.of(context).colorScheme.maintext,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20,) ,
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            Text(
              "Căn cước: ${widget.user.cccd}",
              style: TextStyle(
                fontSize: 22,
                color: Theme.of(context).colorScheme.maintext,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20,) ,
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            Text(
              "Email: ${widget.user.email}",
              style: TextStyle(
                fontSize: 22,
                color: Theme.of(context).colorScheme.maintext,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20,) ,
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            Text(
              "Giới tính: ${widget.user.gender}",
              style: TextStyle(
                fontSize: 22,
                color: Theme.of(context).colorScheme.maintext,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20,) ,
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            Text(
              "Địa chỉ: ${widget.user.address}",
              style: TextStyle(
                fontSize: 22,
                color: Theme.of(context).colorScheme.maintext,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
