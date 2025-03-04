import 'dart:math';

import 'package:flutter/material.dart';

import '../widget/wiget_statistical.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
                child: Column(
                  children: [
                    WigetStatistical()
                  ],
                )
            ),
            Container(
                height: 700,
                width: min(400, MediaQuery.of(context).size.width * 0.2),
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                )
            )
          ],
        )
    );
  }
}
