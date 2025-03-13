import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_admin/model/UserModal.dart';

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
    image: NetworkImage("https://scontent.fsgn2-3.fna.fbcdn.net/v/t1.6435-9/72562816_229878864666821_8846389820843360256_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=86c6b0&_nc_eui2=AeEKVCAY_KyT2llz-WzaToS1iz5p3_gWDWuLPmnf-BYNawXKxoV7kC2JYlC9XJxhCrMXszD4XYPRt3vU2P6AsP3s&_nc_ohc=dOwW53pkQB0Q7kNvgElx8VY&_nc_oc=AdiMUkUIfI9nCBTsEzouGasWpGy5v_Xv4tCzxnviWef0N_axlPSo5GqwmzBicPEEiTPLLKYczIL0oorhIymVmdSP&_nc_zt=23&_nc_ht=scontent.fsgn2-3.fna&_nc_gid=AM2Be9AnR6lyvpu-6m6kqv_&oh=00_AYCSfBtasKGjLDnnpxXvqveKzx8Oj4o1Lytn_Z4S-Y7dPA&oe=67E26691"),
    fit: BoxFit.cover,
  ) ;


  Future<void> loadDataImg() async {
    if (path.isNotEmpty) return; // Tránh load lại nếu đã có dữ liệu

    String? newPath = await UserModel.export_image_avata(widget.userModel.id!);

    if (newPath != null && newPath.isNotEmpty && newPath != path) {
      setState(() {
        path = newPath.replaceAll("\\", "/"); // Chuẩn hóa đường dẫn
        print("$location/$path") ;
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
