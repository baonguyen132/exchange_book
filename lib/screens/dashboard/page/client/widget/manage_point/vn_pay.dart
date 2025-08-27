import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VnPayScreen extends StatelessWidget {
  final String paymentUrl;
  const VnPayScreen({required this.paymentUrl, super.key});

  @override
  Widget build(BuildContext context) {
    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            if (request.url.contains("vnp_ResponseCode")) {
              final uri = Uri.parse(request.url);
              final result = uri.queryParameters['vnp_ResponseCode'];
              Navigator.pop(context, result); // Trả về mã kết quả thanh toán
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(paymentUrl));

    return Scaffold(
      appBar: AppBar(title: const Text('Thanh toán VNPAY')),
      body: WebViewWidget(controller: controller),
    );
  }
}
