import 'package:flutter/material.dart';

import '../../../../../../util/widget_text_field_custom.dart';

class SearchSection extends StatefulWidget {
  final int pointOnePerson;
  final Function(String address) exchangeListId;
  final Function(String value) exchangeListPoint;
  const SearchSection({
    super.key,
    required this.exchangeListId,
    required this.exchangeListPoint,
    required this.pointOnePerson,
  });

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  late TextEditingController searchController;
  late TextEditingController pointController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    pointController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tìm Kiếm & Lọc",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: WidgetTextFieldCustom(
                  controller: searchController,
                  textInputType: TextInputType.text,
                  hint: "Tìm kiếm theo địa chỉ",
                  iconData: Icons.search_rounded,
                  onChange: (address) {
                    widget.exchangeListId(address);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: WidgetTextFieldCustom(
                  controller: pointController,
                  textInputType: TextInputType.text,
                  hint: "Nhập số tiền",
                  iconData: Icons.stars_rounded,
                  onChange: (value) {
                    widget.exchangeListPoint(value);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (widget.pointOnePerson > 0)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.amber.shade50,
                    Colors.orange.shade50,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.amber.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Colors.amber[700],
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Mỗi người nhận: ${widget.pointOnePerson} vnd",
                      style: TextStyle(
                        color: Colors.amber[700],
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
