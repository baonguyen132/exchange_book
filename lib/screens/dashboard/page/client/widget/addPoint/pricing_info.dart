import 'package:flutter/material.dart';

class PricingInfo extends StatefulWidget {
  const PricingInfo({super.key});

  @override
  State<PricingInfo> createState() => _PricingInfoState();
}

class _PricingInfoState extends State<PricingInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.amber.shade50,
            Colors.orange.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.amber.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: Colors.amber[700],
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                "Thông Tin",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.amber[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "• Nạp tối thiểu: 20.000 VND\n• Thanh toán an toàn qua VNPay\n• Điểm được cộng ngay sau khi thanh toán",
            style: TextStyle(
              fontSize: 14,
              color: Colors.amber[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
