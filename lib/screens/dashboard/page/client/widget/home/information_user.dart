import 'package:exchange_book/model/user_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/ConstraintData.dart';

class InformationUser extends StatefulWidget {
  final UserModel userModel ;
  const InformationUser({super.key, required this.userModel});

  @override
  State<InformationUser> createState() => _InformationUserState();
}

class _InformationUserState extends State<InformationUser> {
  String newPath = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImage() ;
  }
  void loadImage() async {
    final path = await UserModel.exportImageAva(widget.userModel.id.toString());
    if (!mounted) return;
    setState(() {
      newPath = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar with border and soft shadow
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Container(
              width: 60,
              height: 60,
              decoration:  BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                image: DecorationImage(
                    image: newPath !="" ? NetworkImage("$location/$newPath") : const NetworkImage("https://aic.com.vn/wp-content/uploads/2024/10/avatar-fb-mac-dinh-1.jpg"),
                    fit: BoxFit.cover
                ),

              ),
            ),
          ),
        ),
        const SizedBox(width: 18),

        // Greeting and name
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Xin chào,',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.95),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.userModel.name.isNotEmpty
                    ? widget.userModel.name
                    : 'Khách hàng',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
