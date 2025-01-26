import 'package:flutter/material.dart';


import '../../data/ConstraintData.dart';
import 'widget/MyDrawer.dart';

class DashboardTablet extends StatefulWidget {
  DashboardTablet({super.key});
  @override
  State<DashboardTablet> createState() => _DashboardTabletState();
}

class _DashboardTabletState extends State<DashboardTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      drawer: Mydrawer(
        selection: mainPage,
        handle: (page) {
          setState(() {
            Navigator.pop(context) ;
            mainPage = page ;
          });
        },
      ),
      body: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 4,
                    child: GridView.builder(
                      itemCount: 4,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                      itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          color: Colors.green,
                        ),

                      ),
                    ),
                  ),
                ],
              ),
            )
          ]
      )
    );
  }
}
