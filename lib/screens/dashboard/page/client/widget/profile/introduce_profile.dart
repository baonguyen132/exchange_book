import 'dart:math';

import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

import 'introduce_profile_edit.dart';
import 'introduce_profile_item.dart';

class IntroduceProfile extends StatefulWidget {
  final double? height;
  final double weight;
  final double margin;
  const IntroduceProfile(
      {super.key, this.height, required this.weight, required this.margin});

  @override
  State<IntroduceProfile> createState() => _IntroduceProfileState();
}

class _IntroduceProfileState extends State<IntroduceProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.weight,
      height: widget.height,
      margin: EdgeInsets.all(widget.margin),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: Colors.white,
        border: Border.all(
          color: Colors.blue.shade100,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.08),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.person_outline,
                    color: Colors.blue.shade600,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Thông tin liên hệ",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue.shade800,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: const [
                        IntroduceProfileItem(
                          text: "Facebook",
                          imageUrl:
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiXN9xSEe8unzPBEQOeAKXd9Q55efGHGB9BA&s",
                          link: "https://facebook.com/user",
                        ),
                        IntroduceProfileItem(
                          text: "GitHub",
                          imageUrl:
                              "https://th.bing.com/th/id/OIP.nK06T8IQhsz5cs8NpOF-dwHaHa?rs=1&pid=ImgDetMain",
                          link: "https://github.com/user",
                        ),
                        IntroduceProfileItem(
                          text: "LinkedIn",
                          imageUrl:
                              "https://th.bing.com/th/id/OIP.W9QKOL8zM4vYCYzYZwbPcAHaHa?rs=1&pid=ImgDetMain",
                          link: "https://linkedin.com/in/user",
                        ),
                        IntroduceProfileItem(
                          text: "Instagram",
                          imageUrl:
                              "https://th.bing.com/th/id/OIP.TNFcmJNZJD5pqcQnCOpWWwHaHa?rs=1&pid=ImgDetMain",
                          link: "https://instagram.com/user",
                        ),
                      ],
                    ),
                  ),

                  // Edit button
                  IntroduceProfileEdit(
                    handle: () {
                      // TODO: Handle edit
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
