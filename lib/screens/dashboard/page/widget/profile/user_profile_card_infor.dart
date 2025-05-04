import 'package:flutter/material.dart';
import 'package:project_admin/model/UserModal.dart';
import 'package:project_admin/theme/theme.dart';

class UserProfileCardInfor extends StatefulWidget {
  UserModel user ;
  UserProfileCardInfor({super.key , required this.user});

  @override
  State<UserProfileCardInfor> createState() => _UserProfileCardInforState();
}

class _UserProfileCardInforState extends State<UserProfileCardInfor> {





  @override
  Widget build(BuildContext context) {



    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.user.name,
          style: TextStyle(
              fontSize: 22,
              color: Colors.blue,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 20,) ,
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
        SizedBox(height: 20,) ,
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
        SizedBox(height: 20,) ,
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
        SizedBox(height: 20,) ,
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
        SizedBox(height: 20,) ,
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
