import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import 'widget/form_scan_qr.dart';

class ScanQrCodeMobile extends StatefulWidget {
  GlobalKey qrkey ;
  QRViewController? controller;

  ScanQrCodeMobile({super.key , required this.qrkey , this.controller});

  @override
  State<ScanQrCodeMobile> createState() => _ScanQrCodeMobileState();
}

class _ScanQrCodeMobileState extends State<ScanQrCodeMobile> {

  @override
  Widget build(BuildContext context) {
    return FormScanQr(qrkey: widget.qrkey , controller: widget.controller,) ;
  }
}
