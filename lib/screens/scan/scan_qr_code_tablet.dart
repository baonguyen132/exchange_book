import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import 'widget/form_scan_qr.dart';

class ScanQrCodeTablet extends StatefulWidget {
  final GlobalKey qrKey ;
  final QRViewController? controller;

  const ScanQrCodeTablet({super.key , required this.qrKey , this.controller});

  @override
  State<ScanQrCodeTablet> createState() => _ScanQrCodeTabletState();
}

class _ScanQrCodeTabletState extends State<ScanQrCodeTablet> {
  @override
  Widget build(BuildContext context) {
    return FormScanQr(qrKey: widget.qrKey , controller: widget.controller,) ;
  }
}
