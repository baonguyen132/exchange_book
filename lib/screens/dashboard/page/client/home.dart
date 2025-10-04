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

                        if (screenWidth > 768) {
                          // Desktop & Tablet: 1 hàng 6 item
                          crossAxisCount = 6;
                        } else {
                          // Mobile: 2 hàng, mỗi hàng 3 item
                          crossAxisCount = 3;
                        }

                        return GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 12, // Tăng khoảng cách
                          crossAxisSpacing: 12,
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
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TranferForUser(
                                          id: data,
                                          idUser: userModel.id.toString(),
                                        ),
                                      ));

                                  if(result) {
                                    int? currentPoint = await UserModel.loadPointData();

                                    setState(() {
                                      userModel.point = currentPoint.toString() ;
                                    });

                                  }

                                }
                              },
                            ),
                            _miniFeatureButton(
                              icon: Icons.swap_horiz,
                              label: 'Quản lý ví',
                              color: Colors.deepOrange,
                              onTap: () async {
                                if (userModel.id != null) {
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ManagePoint(userModel: userModel),
                                      ));

                                  if(result) {
                                    int? currentPoint = await UserModel.loadPointData();

                                    setState(() {
                                      userModel.point = currentPoint.toString() ;
                                    });

                                  }

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
                                  UserModel.savePointData(result) ;
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

  Widget _miniFeatureButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = MediaQuery.of(context).size.width <= 768;

        // Thêm một khoảng đệm bên trong để thu nhỏ nút, đặc biệt trên mobile
        final double internalPadding = isMobile ? 4.0 : 2.0;

        // Kích thước thực tế của nút sẽ nhỏ hơn ô GridView một chút
        final double cellSize = constraints.maxWidth - (internalPadding * 5);

        // Tính toán kích thước các thành phần dựa trên kích thước mới của nút
        final double iconSize = cellSize * 0.30;
        final double fontSize = cellSize * 0.1 ;
        final double borderRadius = cellSize * 0.15;
        final double contentPadding = cellSize * 0.08;

        return Padding(
          padding: EdgeInsets.all(internalPadding),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(borderRadius),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(borderRadius),
              splashColor: color.withOpacity(0.2),
              highlightColor: color.withOpacity(0.1),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      Colors.grey.shade50,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.08),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(contentPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: color,
                      size: iconSize,
                    ),
                    SizedBox(height: cellSize * 0.07),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w600,
                        fontSize: fontSize,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
} // end of _HomeState
