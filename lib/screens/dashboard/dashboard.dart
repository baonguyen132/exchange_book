import 'package:flutter/material.dart';

import '../../util/responsive.dart';
import 'dashboard_desktop.dart';
import 'dashboard_mobile.dart';
import 'dashboard_tablet.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
        desktop: DashboardDesktop(),
        mobile: DashboardMobile(),
        tablet: DashboardTablet()
    );
  }
}
