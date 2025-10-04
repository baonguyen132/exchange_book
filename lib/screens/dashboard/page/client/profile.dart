import 'dart:math';

import 'package:exchange_book/screens/dashboard/page/client/cubit/profile/profile_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/profile/introduce_profile.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/profile/product_profile.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/profile/user_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/user_modal.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  late TabController _tabController;

  String newPath = "";

  void loadImage() async {
    final path = await UserModel.exportImageAva(
        context.read<ProfileCubit>().state.user.id.toString());
    if (!mounted) return;
    setState(() {
      newPath = path;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<ProfileCubit>().loadingData();
    loadImage();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.blue.shade50, // Blue background
          body: CustomScrollView(
            slivers: [
              // App Bar with Cover Photo
              _buildSliverAppBar(state, isMobile),

              // Profile Content
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Profile Header with Avatar and Basic Info
                    _buildProfileHeader(state, isMobile),

                    const SizedBox(height: 24),

                    // Stats Cards
                    _buildStatsSection(state, isMobile, isTablet),

                    const SizedBox(height: 32),

                    // Tab Section
                    _buildTabSection(state, isMobile),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSliverAppBar(ProfileState state, bool isMobile) {
    return SliverAppBar(
      expandedHeight: isMobile ? 200 : 280,
      floating: false,
      pinned: true,
      backgroundColor: Colors.blue.shade700, // Blue theme
      foregroundColor: Colors.white,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade600,
                Colors.blue.shade700,
                Colors.blue.shade800,
              ],
            ),
          ),
          child: Stack(
            children: [
              // Background Pattern
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
                    ),
                  ),
                ),
              ),
              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.blue.withOpacity(0.3), // Blue overlay
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            // TODO: Navigate to edit profile
          },
        ),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {
            // TODO: Share profile
          },
        ),
      ],
    );
  }

  Widget _buildProfileHeader(ProfileState state, bool isMobile) {
    return Transform.translate(
      offset: Offset(0, isMobile ? -40 : -60),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.blue.shade100, // Blue border
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1), // Blue shadow
              spreadRadius: 0,
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Avatar
            Container(
              width: isMobile ? 100 : 120,
              height: isMobile ? 100 : 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue.shade300, // Blue border for avatar
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2), // Blue shadow
                    spreadRadius: 0,
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: isMobile ? 48 : 56,
                backgroundColor: Colors.blue.shade50, // Blue background
                backgroundImage:
                    newPath.isNotEmpty ? NetworkImage(newPath) : null,
                child: newPath.isEmpty
                    ? Icon(
                        Icons.person,
                        size: isMobile ? 40 : 48,
                        color: Colors.blue.shade400, // Blue icon
                      )
                    : null,
              ),
            ),

            const SizedBox(height: 16),

            // Name and Email
            Text(
              state.user.name ?? 'Người dùng',
              style: TextStyle(
                fontSize: isMobile ? 24 : 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800, // Blue text
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            if (state.user.email != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.email_outlined,
                    size: 16,
                    color: Colors.blue.shade600, // Blue icon
                  ),
                  const SizedBox(width: 8),
                  Text(
                    state.user.email!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue.shade600, // Blue text
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Edit profile
                    },
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Chỉnh sửa'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600, // Blue button
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadowColor: Colors.blue.withOpacity(0.3),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Settings
                    },
                    icon: const Icon(Icons.settings, size: 18),
                    label: const Text('Cài đặt'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue.shade600, // Blue text
                      side: BorderSide(
                          color: Colors.blue.shade600), // Blue border
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(ProfileState state, bool isMobile, bool isTablet) {
    final statsData = [
      {
        'icon': Icons.auto_stories,
        'label': 'Sách đã đăng',
        'value': '${state.list?.length ?? 0}',
        'color': Colors.blue.shade600, // All blue theme
      },
      {
        'icon': Icons.swap_horiz,
        'label': 'Lượt trao đổi',
        'value': '24',
        'color': Colors.blue.shade700,
      },
      {
        'icon': Icons.star,
        'label': 'Điểm tích lũy',
        'value': state.user.point ?? '0',
        'color': Colors.blue.shade500,
      },
      {
        'icon': Icons.favorite,
        'label': 'Yêu thích',
        'value': '18',
        'color': Colors.blue.shade800,
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isMobile ? 2 : (isTablet ? 2 : 4),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: isMobile ? 1.2 : 1.1,
        ),
        itemCount: statsData.length,
        itemBuilder: (context, index) {
          final stat = statsData[index];
          return _buildStatCard(
            icon: stat['icon'] as IconData,
            label: stat['label'] as String,
            value: stat['value'] as String,
            color: stat['color'] as Color,
            isMobile: isMobile,
          );
        },
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required bool isMobile,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.blue.shade100, // Blue border
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.08), // Blue shadow
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15), // Blue background
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: isMobile ? 24 : 28,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: isMobile ? 20 : 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800, // Blue text
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: isMobile ? 12 : 14,
              color: Colors.blue.shade600, // Blue text
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection(ProfileState state, bool isMobile) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blue.shade100, // Blue border
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.08), // Blue shadow
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Tab Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade50, // Light blue background
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.blue.shade600, // Blue indicator
                borderRadius: BorderRadius.circular(12),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.all(8),
              labelColor: Colors.white,
              unselectedLabelColor:
                  Colors.blue.shade600, // Blue unselected text
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              tabs: const [
                Tab(
                  icon: Icon(Icons.auto_stories, size: 20),
                  text: 'Sách của tôi',
                ),
                Tab(
                  icon: Icon(Icons.info_outline, size: 20),
                  text: 'Giới thiệu',
                ),
                Tab(
                  icon: Icon(Icons.history, size: 20),
                  text: 'Hoạt động',
                ),
              ],
            ),
          ),

          // Tab Content
          SizedBox(
            height: 600,
            child: TabBarView(
              controller: _tabController,
              children: [
                // Books Tab
                ProductProfile(list: state.list),

                // Introduction Tab
                IntroduceProfile(
                  height: 600,
                  weight: double.infinity,
                  margin: 0,
                ),

                // Activity Tab
                _buildActivityTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTab() {
    final activities = [
      {
        'icon': Icons.swap_horiz,
        'title': 'Trao đổi sách "Doraemon tập 1"',
        'subtitle': 'với Nguyễn Văn A',
        'time': '2 giờ trước',
        'color': Colors.blue.shade600, // Blue theme
      },
      {
        'icon': Icons.favorite,
        'title': 'Yêu thích sách "One Piece tập 100"',
        'subtitle': 'của Trần Thị B',
        'time': '1 ngày trước',
        'color': Colors.blue.shade700,
      },
      {
        'icon': Icons.auto_stories,
        'title': 'Đăng sách mới "Naruto tập 50"',
        'subtitle': 'Thể loại: Manga',
        'time': '3 ngày trước',
        'color': Colors.blue.shade500,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50, // Light blue background
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.blue.shade100, // Blue border
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (activity['color'] as Color).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  activity['icon'] as IconData,
                  color: activity['color'] as Color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade800, // Blue text
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      activity['subtitle'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade600, // Blue text
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                activity['time'] as String,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.blue.shade500, // Blue text
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
