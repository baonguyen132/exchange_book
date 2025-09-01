import 'dart:math';
import 'dart:io';

import 'package:exchange_book/data/ConstraintData.dart';
import 'package:exchange_book/model/user_modal.dart';
import 'package:exchange_book/screens/dashboard/page/client/cubit/add_point/add_point_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/home/article_carousel.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/home/card_point.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/home/information_user.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/home/why_exchange.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../cubit/dashboard_cubit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late UserModel userModel = UserModel(
    name: "",
    email: "",
    password: "",
    cccd: "",
    dob: "",
    gender: "",
    address: "",
    point: "",
  );

  @override
  void initState() {
    super.initState();
    userModel = context.read<DashboardCubit>().state.user;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerHeight = 260.0;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                height: headerHeight,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.primaryColor,
                      theme.primaryColor.withOpacity(0.85),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row - avatar + greeting
                    InformationUser(userModel: userModel),
                    const SizedBox(height: 14),
                    Text(
                      'Sách không bỏ đi tri thức còn ở lại!',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.95),
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

              // Stack section with overlapping CardPoint
              SizedBox(
                height: 120,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      top: 0,
                      child: Container(),
                    ),
                    Positioned(
                      top: -100,
                      left: 0,
                      right: 0,
                      child: CardPoint(
                        point: userModel.point,
                        barcode: "${userModel.id}-${userModel.cccd}",
                      ),
                    ),
                  ],
                ),
              ),

              // Quick actions and content
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chức năng nhanh',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    const SizedBox(height: 12),

                    SizedBox(
                      height:
                          110, // fixed height to avoid layout/overflow issues
                      child: GridView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.85,
                        ),
                        children: [
                          _miniFeatureButton(
                            icon: Icons.qr_code_scanner,
                            label: 'Quét mã',
                            color: Colors.blue,
                            onTap: () {
                              // TODO: Thêm chức năng scan barcode
                            },
                          ),
                          _miniFeatureButton(
                            icon: Icons.swap_horiz,
                            label: 'Chuyển điểm',
                            color: Colors.green,
                            onTap: () {
                              // TODO: Thêm chức năng chuyển điểm
                            },
                          ),
                          _miniFeatureButton(
                            icon: Icons.history,
                            label: 'Lịch sử',
                            color: Colors.orange,
                            onTap: () {
                              // TODO: Thêm chức năng lịch sử giao dịch
                            },
                          ),
                          _miniFeatureButton(
                            icon: Icons.more_horiz,
                            label: 'Khác',
                            color: Colors.grey,
                            onTap: () {
                              // TODO: Thêm chức năng khác
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Mục tuyên truyền trao đổi sách
                    Text(
                      'Tại sao nên trao đổi sách?',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    const SizedBox(height: 14),
                    const WhyExchange() ,
                    // Article carousel: horizontal list of related articles
                    const SizedBox(height: 16),
                    Text(
                      'Những bài báo',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    const SizedBox(height: 14),
                    const ArticleCarousel(),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper: mini feature button for quick actions grid
  Widget _miniFeatureButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // Helper: nicer promo row used in the promo container






} // end of _HomeState
