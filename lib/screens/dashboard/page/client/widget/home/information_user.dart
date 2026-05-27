import 'package:exchange_book/model/user_modal.dart';
import 'package:flutter/material.dart';
import '../../../../../../data/ConstraintData.dart';

class InformationUser extends StatefulWidget {
  final UserModel userModel;
  const InformationUser({super.key, required this.userModel});

  @override
  State<InformationUser> createState() => _InformationUserState();
}

class _InformationUserState extends State<InformationUser> {
  String newPath = "";

  @override
  void initState() {
    super.initState();
    loadImage();
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
        // Avatar
        Container(
          padding: const EdgeInsets.all(2.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.9),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: newPath != ""
                ? NetworkImage("$location/$newPath")
                : const NetworkImage(
                    "https://aic.com.vn/wp-content/uploads/2024/10/avatar-fb-mac-dinh-1.jpg"),
          ),
        ),
        const SizedBox(width: 14),

        // Greeting
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Xin chào 👋',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                widget.userModel.name.isNotEmpty
                    ? widget.userModel.name
                    : 'Khách hàng',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.3,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        // Notification bell (decorative)
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.notifications_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
      ],
    );
  }
}
