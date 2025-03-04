import 'package:flutter/material.dart';
import 'package:project_admin/theme/theme.dart';

class UserProfileCardInfor extends StatefulWidget {
  const UserProfileCardInfor({super.key});

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
          "Hồ Bảo Nguyên",
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
                "Tuổi: 20",
                style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.maintext,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal
                ),
              ),
              Text(
                "Ngày sinh: 2004-02-13",
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
              "Căn cước: 048204007137",
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
              "Email: nguyenhb.22it@vku.udn.vn",
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
              "Giới tích: Nam",
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
              "Địa chỉ: Tổ 33, Hoà Quý, Ngũ Hành Sơn, Đà Nẵng",
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
