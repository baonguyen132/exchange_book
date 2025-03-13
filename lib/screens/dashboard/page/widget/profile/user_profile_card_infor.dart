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
  int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;

    // Kiểm tra nếu chưa đến sinh nhật năm nay thì trừ đi 1 tuổi
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

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
        Container(
          width: 400,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              Text(
                "Tuổi: ${calculateAge(DateTime.parse(widget.user.dob))}",
                style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.maintext,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal
                ),
              ),
              Text(
                "Ngày sinh: ${widget.user.dob}",
                style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.maintext,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal
                ),
              ),

            ],
          ),
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
              "Giới tích: ${widget.user.gender}",
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
