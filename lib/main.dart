import 'package:another_qr_code_app/create_qr_code_page.dart';
import 'package:another_qr_code_app/scan_qr_code_page.dart';
import 'package:another_qr_code_app/share_qr_code_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constraints.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Scanner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: kBackgroundColorMain,
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: 'QR Code Scanner'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColorMain,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 28.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          children: [
            FrontButton(
                title: "Scan",
                icon: Icons.scanner,
                buttonAction: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => QrCodeScan(),
                  ));
                }),
            FrontButton(
                title: "Create",
                icon: Icons.add_circle_outline,
                buttonAction: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          CreateQrCodePage(title: "Create Qr Code"),
                    ),
                  );
                }),
            FrontButton(
              title: "Share",
              icon: Icons.share,
              buttonAction: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ShareQrCodePage(title: "Share your Qr Code"),
                ));
              },
            ),
            FrontButton(
                title: "Dash",
                icon: Icons.flutter_dash,
                buttonAction: () {
                  launchURLApp("launchURLApp");
                })
          ],
        ),
      ),
    );
  }
}

void launchURLApp(String s) async {
  const url = 'https://www.geeksforgeeks.org/';
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: true, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}

class FrontButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback buttonAction;

  const FrontButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.buttonAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _borderRadius = BorderRadius.circular(16.0);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: kMainButtonColor,
        borderRadius: _borderRadius,
        child: InkWell(
          borderRadius: _borderRadius,
          onTap: buttonAction,
          splashColor: Colors.black54,
          child: Container(
            margin: EdgeInsets.all(28.0),
            height: 200,
            width: 200,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Icon(
                      this.icon,
                      size: 80,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      this.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
