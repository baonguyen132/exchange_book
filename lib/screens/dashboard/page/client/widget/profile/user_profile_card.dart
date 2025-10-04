import 'package:exchange_book/screens/dashboard/page/client/widget/profile/user_profile_card_img.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/profile/user_profile_card_information.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/model/user_modal.dart';

class UserProfileCard extends StatefulWidget {
  final bool isMobile;
  final UserModel userModel;
  const UserProfileCard(
      {super.key, this.isMobile = false, required this.userModel});

  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blue.shade100,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 25,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: widget.isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        // Header with gradient background
        Container(
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade600,
                Colors.blue.shade800,
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Stack(
            children: [
              // Background pattern
              Positioned.fill(
                child: Opacity(
                  opacity: 0.1,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?ixlib=rb-4.0.3'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Profile content
        Transform.translate(
          offset: const Offset(0, -60),
          child: Column(
            children: [
              // Avatar
              UserProfileCardImg(
                isMobile: widget.isMobile,
                userModel: widget.userModel,
              ),

              const SizedBox(height: 16),

              // User information
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: UserProfileCardInformation(user: widget.userModel),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left side - Image and gradient
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade600,
                    Colors.blue.shade800,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  // Background pattern
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.1,
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?ixlib=rb-4.0.3'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Avatar positioned
                  Center(
                    child: UserProfileCardImg(
                      isMobile: widget.isMobile,
                      userModel: widget.userModel,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right side - Information
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(32),
              child: UserProfileCardInformation(user: widget.userModel),
            ),
          ),
        ],
      ),
    );
  }
}
