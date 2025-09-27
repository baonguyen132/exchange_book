import 'dart:math';

import 'package:exchange_book/data/ConstraintData.dart';
import 'package:exchange_book/data/SideMenuData.dart';
import 'package:exchange_book/model/user_modal.dart';
import 'package:exchange_book/screens/dashboard/page/client/assistant.dart';
import 'package:exchange_book/screens/dashboard/page/client/manage_point.dart';
import 'package:exchange_book/screens/dashboard/page/client/question.dart';
import 'package:exchange_book/screens/dashboard/page/client/tranfer_for_user.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/home/article_carousel.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/home/card_point.dart';
import 'package:exchange_book/screens/dashboard/page/client/contribute_ideas.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/home/information_user.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/home/why_exchange.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage/widget_sign_up_book.dart';
import 'package:exchange_book/screens/scan/scan_qr_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import '../../../../model/book_modal.dart';
import '../../cubit/dashboard_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/home/green_knowledge_board.dart';

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
                      textAlign: TextAlign.center,
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
                        qrData: '${userModel.id}-${userModel.cccd}',
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
                    // First row of buttons - responsive grid
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final screenWidth = MediaQuery.of(context).size.width;
                        int crossAxisCount;
                        double childAspectRatio;

                        if (screenWidth > 1024) {
                          // Desktop
                          crossAxisCount = 6;
                          childAspectRatio = 0.9;
                        } else if (screenWidth > 768) {
                          // Tablet
                          crossAxisCount = 5;
                          childAspectRatio = 0.85;
                        } else if (screenWidth > 600) {
                          // Large mobile
                          crossAxisCount = 4;
                          childAspectRatio = 0.8;
                        } else {
                          // Small mobile
                          crossAxisCount = 4;
                          childAspectRatio = 0.75;
                        }

                        return GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: childAspectRatio,
                          children: [
                            _miniFeatureButton(
                              icon: Icons.book_outlined,
                              label: 'Đăng sách',
                              color: Colors.indigo,
                              onTap: () {
                                if (userModel.id != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WidgetSignUpBook(
                                          user: userModel,
                                          insert: (bookModal) {
                                            BookModal.updateDatabaseBook(
                                              bookModal,
                                              "$location/insertBook",
                                                  () {
                                                toast("Thêm thành công");
                                                context
                                                    .read<DashboardCubit>()
                                                    .exchange(
                                                    listmenu[2], true);
                                              },
                                                  () {
                                                toast("Thêm không thành công");
                                              },
                                            );
                                          },
                                        ),
                                      ));
                                }
                              },
                            ),
                            _miniFeatureButton(
                              icon: Icons.qr_code_scanner,
                              label: 'Quét mã',
                              color: Colors.teal,
                              onTap: () async {
                                if (userModel.id != null) {
                                  String data = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const ScanQrCode(),
                                      ));
                                  String result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TranferForUser(
                                          id: data,
                                          idUser: userModel.id.toString(),
                                        ),
                                      ));
                                  toast(result);
                                }
                              },
                            ),
                            _miniFeatureButton(
                              icon: Icons.swap_horiz,
                              label: 'Quản lý ví',
                              color: Colors.deepOrange,
                              onTap: () {
                                if (userModel.id != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ManagePoint(userModel: userModel),
                                      ));
                                }
                              },
                            ),
                            _miniFeatureButton(
                              icon: Icons.chat,
                              label: 'Đóng góp ý kiến',
                              color: Colors.purple,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                      const ContributeIdeas(),
                                    ));
                              },
                            ),
                            _miniFeatureButton(
                              icon: Icons.smart_toy_rounded,
                              label: 'Trợ lý AI',
                              color: Colors.cyan,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Assistant(),
                                    ));
                              },
                            ),
                            _miniFeatureButton(
                              icon: Icons.quiz_rounded,
                              label: 'Quiz',
                              color: Colors.amber.shade700,
                              onTap: () async {
                                final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Question(
                                        userModel: userModel,
                                      ),
                                    ));

                                if (result != null) {
                                  setState(() {
                                    userModel.point = result.toString();
                                  });
                                }
                              },
                            ),
                          ],
                        );
                      },
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
                    const WhyExchange(),

                    const SizedBox(height: 24),

                    // Bảng vinh danh tri thức xanh
                    const GreenKnowledgeBoard(),

                    const SizedBox(height: 16),
                    Text(
                      'Một nét bút chì ngàn cuốn sách được trao',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
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
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive values based on available width
        final availableWidth = constraints.maxWidth;
        final screenWidth = MediaQuery.of(context).size.width;

        // Responsive dimensions
        double iconSize;
        double fontSize;
        double borderRadius;
        double padding;
        int maxLines;

        if (screenWidth > 1024) {
          // Desktop
          iconSize = min(28, availableWidth * 0.25);
          fontSize = min(11, availableWidth * 0.08);
          borderRadius = 14;
          padding = 8;
          maxLines = 2;
        } else if (screenWidth > 768) {
          // Tablet
          iconSize = min(24, availableWidth * 0.25);
          fontSize = min(10, availableWidth * 0.08);
          borderRadius = 12;
          padding = 6;
          maxLines = 2;
        } else {
          // Mobile
          iconSize = min(20, availableWidth * 0.25);
          fontSize = min(9, availableWidth * 0.08);
          borderRadius = 10;
          padding = 4;
          maxLines = 2;
        }

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(borderRadius),
            splashColor: color.withOpacity(0.2),
            highlightColor: color.withOpacity(0.1),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight * 0.8,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color.withOpacity(0.15),
                    color.withOpacity(0.08),
                  ],
                ),
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: color.withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon with container
                  Container(
                    padding: EdgeInsets.all(padding / 2),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: iconSize,
                    ),
                  ),

                  SizedBox(height: padding / 2),

                  // Label with responsive text
                  Flexible(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: color.withOpacity(0.9),
                        fontWeight: FontWeight.w600,
                        fontSize: fontSize,
                        height: 1.1,
                      ),
                      maxLines: maxLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
} // end of _HomeState
