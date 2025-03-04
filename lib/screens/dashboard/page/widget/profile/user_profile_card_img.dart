import 'package:flutter/material.dart';

class UserProfileCardImg extends StatefulWidget {
  bool isMobile ;
  UserProfileCardImg({super.key , required this.isMobile});

  @override
  State<UserProfileCardImg> createState() => _UserProfileCardImgState();
}

class _UserProfileCardImgState extends State<UserProfileCardImg> {

  final backgoundDecorationImage = const DecorationImage(
    image: NetworkImage("https://scontent.fsgn2-3.fna.fbcdn.net/v/t1.6435-9/72562816_229878864666821_8846389820843360256_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=86c6b0&_nc_eui2=AeEKVCAY_KyT2llz-WzaToS1iz5p3_gWDWuLPmnf-BYNawXKxoV7kC2JYlC9XJxhCrMXszD4XYPRt3vU2P6AsP3s&_nc_ohc=dOwW53pkQB0Q7kNvgElx8VY&_nc_oc=AdiMUkUIfI9nCBTsEzouGasWpGy5v_Xv4tCzxnviWef0N_axlPSo5GqwmzBicPEEiTPLLKYczIL0oorhIymVmdSP&_nc_zt=23&_nc_ht=scontent.fsgn2-3.fna&_nc_gid=AM2Be9AnR6lyvpu-6m6kqv_&oh=00_AYCSfBtasKGjLDnnpxXvqveKzx8Oj4o1Lytn_Z4S-Y7dPA&oe=67E26691"),
    fit: BoxFit.cover,
  ) ;

  final avataBoxDecoration =  BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(100))  ,
    image: const DecorationImage(
      image: NetworkImage("https://scontent.fsgn2-8.fna.fbcdn.net/v/t39.30808-6/477212107_1399516171036412_4316852747341725036_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeEtCMcfxqCW4xzpFpp8A3VYhcupsiavGCiFy6myJq8YKLbYwofUno0sBtn9opZsw75vYJQf4irJDm8fr3mlWgbr&_nc_ohc=BA2JQPbuFAAQ7kNvgF8W6Yb&_nc_oc=AdiBP_zuVA-NJPAx6xXBwBcui9HrvegomRhczBqeurVsmtefWUPTAEiMGBjzagF-UoVZ7CoXNuguODx4iV6EM_nl&_nc_zt=23&_nc_ht=scontent.fsgn2-8.fna&_nc_gid=AzHBMRLIJOqTcy4c-FY58eF&oh=00_AYB2epTOScZsWtTmgeqvDAP8L5N5Qp9Xrmn5KMgMAv0KAQ&oe=67C0C8EA"),
      fit: BoxFit.cover,
    ),
    border: Border.all(
        width: 5,
        color: Colors.white
    ),
  ) ;

  @override
  Widget build(BuildContext context) {
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
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)
                )
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
        !widget.isMobile ?
        Positioned(
          top: 30,
          right: 0,
          child: Container(
            width: 180,
            height: 180,
            decoration: avataBoxDecoration,
          ),
        )
            :
        Positioned(
          bottom: 0,
          left: 20,
          child: Container(
            width: 200,
            height: 200,
            decoration: avataBoxDecoration,
          ),
        )
      ],
    );
  }
}
