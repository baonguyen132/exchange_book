import 'dart:io';

import 'package:flutter/material.dart';
import 'package:exchange_book/screens/scan/scan_qr_code_desktop.dart';
import 'package:exchange_book/screens/scan/scan_qr_code_mobile.dart';
import 'package:exchange_book/screens/scan/scan_qr_code_tablet.dart';
import 'package:exchange_book/util/responsive.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key});

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  final qrkey = GlobalKey(debugLabel:  'QR') ;
  QRViewController? controller ;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller?.dispose() ;
  }

  @override
  void reassemble() async {
    // TODO: implement reassemble
    super.reassemble();

    if(Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
        desktop: ScanQrCodeDesktop(),
        mobile: ScanQrCodeMobile(qrKey: qrkey, controller: controller,),
        tablet: ScanQrCodeTablet(qrKey: qrkey, controller: controller,)
    );
  }
}
