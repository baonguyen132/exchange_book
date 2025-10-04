import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:exchange_book/model/user_modal.dart';
import '../../../../../../data/ConstraintData.dart';

class UserProfileCardImg extends StatefulWidget {
  final bool isMobile;
  final UserModel userModel;
  const UserProfileCardImg(
      {super.key, required this.isMobile, required this.userModel});

  @override
  State<UserProfileCardImg> createState() => _UserProfileCardImgState();
}

class _UserProfileCardImgState extends State<UserProfileCardImg> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String path = "";
  bool _isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    setState(() {
      _isLoading = true;
    });

    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        path = "";
        _image = File(pickedFile.path);
      });

      await UserModel.uploadImage(
          _image!, widget.userModel.cccd, "0", widget.userModel.id!);
      await loadDataImg();
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> loadDataImg() async {
    if (path.isNotEmpty) return;

    String? newPath = await UserModel.exportImageAva(widget.userModel.id!);
    if (newPath != null && newPath.isNotEmpty && newPath != path) {
      setState(() {
        path = newPath.replaceAll("\\", "/");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadDataImg();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Avatar container
        Container(
          width: widget.isMobile ? 120 : 160,
          height: widget.isMobile ? 120 : 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 6,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: widget.isMobile ? 54 : 74,
            backgroundColor: Colors.blue.shade100,
            backgroundImage:
                path.isNotEmpty ? NetworkImage("$location/$path") : null,
            child: _isLoading
                ? CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
                  )
                : path.isEmpty
                    ? Icon(
                        Icons.person,
                        size: widget.isMobile ? 50 : 70,
                        color: Colors.blue.shade400,
                      )
                    : null,
          ),
        ),

        // Edit button
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => _showImagePickerOptions(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Thay đổi ảnh đại diện',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildImageOption(
                      icon: Icons.photo_library,
                      label: 'Thư viện',
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildImageOption(
                      icon: Icons.camera_alt,
                      label: 'Chụp ảnh',
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.blue.shade100,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.blue.shade600,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
