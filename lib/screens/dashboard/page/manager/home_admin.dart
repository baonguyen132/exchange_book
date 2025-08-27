import 'package:exchange_book/screens/dashboard/page/manager/widget/home_admin/health_info.dart';
import 'package:exchange_book/screens/dashboard/page/manager/widget/home_admin/schedule_card.dart';
import 'package:exchange_book/screens/dashboard/page/manager/widget/home_admin/summary_card.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../model/user_modal.dart';

class HomeAdmin extends StatefulWidget {

  final UserModel user ;
  const HomeAdmin({super.key, required this.user});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      body: SafeArea(
        child: isMobile
            ? SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildLeftPanel(isMobile: isMobile),
              const SizedBox(height: 16),
            ],
          ),
        )
            : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _buildLeftPanel(isMobile: isMobile),
              ),
            ),
            Expanded(flex: 2, child: _buildRightPanel(widget.user)),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftPanel({required bool isMobile}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.black54),
              const SizedBox(width: 8),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (isMobile) {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => Scaffold(
                          appBar: AppBar(title: const Text("Profile")),
                          body: _buildRightPanel(widget.user),
                        ),
                        transitionsBuilder: (_, animation, __, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          final tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: Curves.ease));
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  }
                },
                child: const CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(
                      "https://i.pinimg.com/736x/8b/2a/4d/8b2a4d1dc4ddb8d49626d497768d661b.jpg"),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        isMobile
            ? const Column(
          children: [
            Row(
              children: [
                Expanded(child: SummaryCard(icon: Icons.person, label: "User", value: "105")),
                SizedBox(width: 8),
                Expanded(child: SummaryCard(icon: Icons.book_outlined, label: "Books", value: "86")),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: SummaryCard(icon: Icons.post_add, label: "Posts", value: "25")),
                SizedBox(width: 8),
                Expanded(child: SummaryCard(icon: Icons.feedback_outlined, label: "Feedback", value: "10")),
              ],
            ),
          ],
        )
            : const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SummaryCard(icon: Icons.person, label: "User", value: "105"),
            SummaryCard(icon: Icons.book_outlined, label: "Books", value: "86"),
            SummaryCard(icon: Icons.post_add, label: "Posts", value: "25"),
            SummaryCard(icon: Icons.feedback_outlined, label: "Feedback", value: "10"),
          ],
        ),

        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(16),
          ),
          height: 280,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Overview", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              Expanded(child: LineChart(lineChartData())),
            ],
          ),
        ),
        const SizedBox(height: 16),
        isMobile
            ? Column(
          children: [
            buildSmallChart(title: "Activity Level", data: [4, 5, 4, 2, 2, 3], color: Colors.amber),
            const SizedBox(height: 8),
            buildSmallChart(title: "Nutrition of User", data: [3, 4, 3.5, 2.5, 2.5, 3], color: Colors.pinkAccent),
            const SizedBox(height: 8),
            buildSmallChart(title: "Post", data: [3, 4.5, 3.5, 2, 2, 4.5], color: Colors.lightBlue),
          ],
        )
            : Row(
          children: [
            Expanded(
              child: buildSmallChart(title: "Activity Level", data: [4, 5, 4, 2, 2, 3], color: Colors.amber),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: buildSmallChart(title: "Nutrition of User", data: [3, 4, 3.5, 2.5, 2.5, 3], color: Colors.pinkAccent),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: buildSmallChart(title: "Post", data: [3, 4.5, 3.5, 2, 2, 4.5], color: Colors.lightBlue),
            ),
          ],
        ),

      ],
    );
  }

  Widget _buildRightPanel(UserModel user) {
    return Container(
      color: const Color(0xFFEFEFEF),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage("https://i.pinimg.com/736x/8b/2a/4d/8b2a4d1dc4ddb8d49626d497768d661b.jpg"),
          ),
          const SizedBox(height: 8),
          Text( user.name , style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Text("Edit profile", style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HealthInfo(title: "Email", value: user.email),
              HealthInfo(title: "Address", value: user.address.split(",").last),
            ],
          ),
          const SizedBox(height: 24),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Scheduled", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          const ScheduleCard(title: "Check Posts", time: "Today, 9AM - 10AM"),
          const ScheduleCard(title: "Update UI", time: "Tomorrow, 5PM - 6PM"),
          const ScheduleCard(title: "View Books", time: "Wednesday, 9AM - 10AM"),
        ],
      ),
    );
  }

  Widget buildSmallChart({required String title, required List<double> data, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: BarChart(buildBarChartData(data, color)),
          ),
        ],
      ),
    );
  }

  BarChartData buildBarChartData(List<double> values, Color color) {
    return BarChartData(
      barTouchData: BarTouchData(enabled: false),
      titlesData: FlTitlesData(
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, _) {
              const days = ['M', 'T', 'W', 'T', 'F', 'S'];
              return Text(days[value.toInt()], style: const TextStyle(fontSize: 10));
            },
            interval: 1,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      barGroups: values.asMap().entries.map((entry) {
        int index = entry.key;
        double val = entry.value;
        return BarChartGroupData(x: index, barRods: [
          BarChartRodData(toY: val, color: color, width: 14, borderRadius: BorderRadius.circular(4)),
        ]);
      }).toList(),
    );
  }
}


LineChartData lineChartData() {
  return LineChartData(
    gridData: const FlGridData(show: false),
    borderData: FlBorderData(show: false),
    titlesData: FlTitlesData(
      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 32,
          getTitlesWidget: (value, _) {
            const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            return Text(months[value.toInt() % 12], style: const TextStyle(color: Colors.black54, fontSize: 10));
          },
          interval: 1,
        ),
      ),
    ),
    lineBarsData: [
      LineChartBarData(
        spots: [
          const FlSpot(0, 2),
          const FlSpot(1, 2),
          const FlSpot(2, 4),
          const FlSpot(3, 7),
          const FlSpot(4, 5),
          const FlSpot(5, 9),
          const FlSpot(6, 8),
          const FlSpot(7, 7),
          const FlSpot(8, 7),
          const FlSpot(9, 8),
          const FlSpot(10, 4),
          const FlSpot(11, 6),
        ],
        isCurved: true,
        color: Colors.tealAccent,
        barWidth: 3,
        dotData: const FlDotData(show: false),
      )
    ],
  );
}




