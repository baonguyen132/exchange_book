import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_admin/screens/scan/widget/widget_build_result.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class FormScanQr extends StatefulWidget {
  GlobalKey qrkey ;
  QRViewController? controller;

  FormScanQr({super.key , required this.qrkey , this.controller });

  @override
  State<FormScanQr> createState() => _FormScanQrState();
}

class _FormScanQrState extends State<FormScanQr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildViewQR(context),
          Positioned(bottom: 10,child: WidgetBuildResult() ,),
          Positioned(top: 10 , child: buildControllerButtons(),)
        ],
      ),
    );
  }

  Widget buildControllerButtons() => Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white24
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () async {
              await widget.controller?.toggleFlash() ;
              setState(() {

              });
            },
            icon: FutureBuilder(
              future: widget.controller?.getFlashStatus(),
              builder: (context, snapshot) {
                if(snapshot.data != null){
                  return Icon(
                      snapshot.data! ? Icons.flash_on : Icons.flash_off
                  );
                }
                else {
                  return Container() ;
                }
              },
            )
        ),
        IconButton(
            onPressed: () async {
              await widget.controller?.flipCamera();
              setState(() {

              });
            },
            icon: FutureBuilder(
              future: widget.controller?.getCameraInfo(),
              builder: (context, snapshot) {
                if(snapshot.data != null){
                  return Icon(Icons.switch_camera) ;
                }
                else {
                  return Container() ;
                }
              },
            )
        )
      ],
    ),
  );

  Widget buildViewQR(BuildContext context) => QRView(
    key: widget.qrkey,
    onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
        cutOutSize: min(200, MediaQuery.of(context).size.width * 0.8) ,
        borderWidth: 10,
        borderLength: 25,
        borderRadius: 8,
        borderColor: Colors.blue

    ),
  );

  void onQRViewCreated(QRViewController controller) {
    setState(() => widget.controller = controller,);
    controller.scannedDataStream.listen(
          (event) {
            Navigator.pop(context , event.code.toString()) ;
          },
    );
  }


}
