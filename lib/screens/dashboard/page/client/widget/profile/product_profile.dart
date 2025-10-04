import 'package:flutter/material.dart';
import 'package:exchange_book/screens/dashboard/widget/card/card_item.dart';
import 'package:exchange_book/theme/theme.dart';

import '../../../../../../data/ConstraintData.dart';



class ProductProfile extends StatefulWidget {
  final List<dynamic> list ;
  const ProductProfile({super.key, required this.list});

  @override
  State<ProductProfile> createState() => _ProductProfileState();
}

class _ProductProfileState extends State<ProductProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.mainCard,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Màu bóng
            blurRadius: 10, // Độ mờ của bóng
            spreadRadius: 2, // Độ lan rộng của bóng
            offset: const Offset(0, 4), // Vị trí bóng (x, y)
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Sách",
              style: TextStyle(
                fontSize: 22,
                color: Colors.blue,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 500,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0).copyWith(bottom: 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.list.length,
              itemBuilder: (context, index) => CardItem(
                width: 300,
                heart: true,
                link: "$location/${widget.list[index][6]}",
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "📖 Sách: ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue, // hoặc tùy thuộc vào theme
                              decoration: TextDecoration.none,
                            ),
                          ),
                          TextSpan(
                            text: widget.list[index][1],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).colorScheme.maintext,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Còn lại: ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          TextSpan(
                            text: "${widget.list[index][10]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).colorScheme.maintext,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "💰 Giá: ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          TextSpan(
                            text: "${widget.list[index][4]} VND",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).colorScheme.maintext,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
