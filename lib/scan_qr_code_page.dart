import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validators/validators.dart' as validator;

import 'constraints.dart';

class QrCodeScan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QrCodeScanState();
}

class _QrCodeScanState extends State<QrCodeScan> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColorMain,
      body: Stack(
        children: <Widget>[
          _buildQrView(context),
          Container(
            child: Positioned(
              bottom: 1,
              left: (MediaQuery.of(context).size.width / 2) - 35,
              child: ElevatedButton(
                child: Text("MOCK"),
                onPressed: () {
                  setState(() {
                    result = Barcode(
                        "https://api.flutter.dev/flutter/material/AlertDialog-class.html",
                        BarcodeFormat.qrcode,
                        [1, 2, 3]);
                    /* result = Barcode("AlertDialog-class",
                                BarcodeFormat.qrcode, [1, 2, 3]); */
                  });
                },
              ),
            ),
          ),
          _scanResultView(),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.amber,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  _launchURLApp(String url) async {
    // const url = 'https://www.geeksforgeeks.org/';
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: true, forceWebView: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _scanResultView() {
    if (result != null) {
      if (validator.isURL(result!.code.toString())) {
        return AlertDialog(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 2.0,
          content: Text(
              'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => _launchURLApp(result!.code.toString()),
              child: const Text('Open'),
            ),
          ],
        );
      } else {
        return Text(
            'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}');
      }
    } else
      return Container();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
