import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import 'widget/form_scan_qr.dart';

class ScanQrCodeTablet extends StatefulWidget {
  GlobalKey qrkey ;
  QRViewController? controller;

  ScanQrCodeTablet({super.key , required this.qrkey , this.controller});

  @override
  State<ScanQrCodeTablet> createState() => _ScanQrCodeTabletState();
}

class _ScanQrCodeTabletState extends State<ScanQrCodeTablet> {
  @override
  Widget build(BuildContext context) {
    return FormScanQr(qrkey: widget.qrkey , controller: widget.controller,) ;
  }
}
