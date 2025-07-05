import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

class IntroduceProfileItem extends StatefulWidget {
  final String text;
  final String imageUrl;

  const IntroduceProfileItem({
    super.key,
    required this.text,
    required this.imageUrl,
  });

  @override
  State<IntroduceProfileItem> createState() => _IntroduceProfileItemState();
}

class _IntroduceProfileItemState extends State<IntroduceProfileItem> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.text,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.maintext,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
