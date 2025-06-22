import 'package:flutter/material.dart';
import 'package:exchange_book/screens/scan/scan_qr_code.dart';

class WidgetScanQrCode extends StatefulWidget {
  final Function (String data) handleScanQR ;
  const WidgetScanQrCode({super.key , required this.handleScanQR});

  @override
  State<WidgetScanQrCode> createState() => _WidgetScanQrCodeState();
}

class _WidgetScanQrCodeState extends State<WidgetScanQrCode> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)
                  ),
                  border: Border(
                      top: BorderSide(
                        color: Colors.blue,
                        width: 1.2 ,
                      ),
                      bottom: BorderSide(
                        color: Colors.blue,
                        width: 1.2 ,
                      ),
                      left: BorderSide(
                        color: Colors.blue,
                        width: 1.2 ,
                      )
                  ),
              ),
              child: Container(
                height: 55,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(13),
                child: const Text(
                  "Scan QR on CID",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 120,
            height: 55,
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(
                      color: Colors.blue,
                      width: 1.2 ,
                    ),
                    bottom: BorderSide(
                      color: Colors.blue,
                      width: 1.2 ,
                    ),
                    right: BorderSide(
                      color: Colors.blue,
                      width: 1.2 ,
                    )
                ),
                color: Colors.blue,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(8) , topRight: Radius.circular(8))
            ),
            child: GestureDetector(
              onTap: () async {
                String data = await Navigator.push(context, MaterialPageRoute(builder: (context) => const ScanQrCode(),));
                widget.handleScanQR(data) ;
              },
              child: const MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.qr_code_scanner,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5,),
                    Text(
                      "Scan",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
