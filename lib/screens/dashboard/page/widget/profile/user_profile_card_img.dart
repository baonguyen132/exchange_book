import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:exchange_book/model/UserModal.dart';

import '../../../../../data/ConstraintData.dart';




class UserProfileCardImg extends StatefulWidget {
  bool isMobile ;
  UserModel userModel ;
  UserProfileCardImg({super.key , required this.isMobile , required this.userModel});

  @override
  State<UserProfileCardImg> createState() => _UserProfileCardImgState();
}

class _UserProfileCardImgState extends State<UserProfileCardImg> {

  File? _image;
  final ImagePicker _picker = ImagePicker();
  String path = "" ;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        path = "" ;
        _image = File(pickedFile.path);
        UserModel.uploadImage(_image! , widget.userModel.cccd , "0" , widget.userModel.id!) ;
        loadDataImg() ;
      });
    }
  }

  final backgoundDecorationImage = const DecorationImage(
    image: NetworkImage("https://th.bing.com/th/id/OIP.wLWdXsVzTDNeMJcSnKbIbgHaEK?rs=1&pid=ImgDetMain"),
    fit: BoxFit.cover,
  ) ;


  Future<void> loadDataImg() async {
    if (path.isNotEmpty) return; // Tránh load lại nếu đã có dữ liệu

    String? newPath = await UserModel.export_image_avata(widget.userModel.id!);

    if (newPath != null && newPath.isNotEmpty && newPath != path) {
      setState(() {
        path = newPath.replaceAll("\\", "/"); // Chuẩn hóa đường dẫn
      });
    }
  }


  BoxDecoration getAvataBoxDecoration() {
    return BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      image: path.isNotEmpty
          ? DecorationImage(
        image: NetworkImage("$location/$path"),
        fit: BoxFit.cover,
      )
          : null,
      border: Border.all(width: 5, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    loadDataImg() ;

    return Stack(
      children: [
        !widget.isMobile ?
        Container(
          width: 250,
          decoration: BoxDecoration(
              image: backgoundDecorationImage,
              borderRadius: const  BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)
              )
          ) ,
          child: GestureDetector(
            onTap: () {

            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)
                  )
              ),
            ),
          ),
        ):
        Container(
          height: 280,
          decoration: BoxDecoration(
              image: backgoundDecorationImage,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)
              )
          ),
          child: GestureDetector(
            onTap: () {

            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)
                  )
              ),
            ),
          ),
        ),
        !widget.isMobile ?
        Positioned(
          top: 30,
          right: 0,
          child: Container(
            width: 180,
            height: 180,
            decoration: getAvataBoxDecoration(),
          ),
        )
            :
        Positioned(
          bottom: 0,
          left: 20,
          child: GestureDetector(
            onTap: () {
              _pickImage(ImageSource.gallery) ;
            },
            child: Container(
              width: 200,
              height: 200,
              decoration: getAvataBoxDecoration(),
            ),
          ),
        )
      ],
    );
  }
}
