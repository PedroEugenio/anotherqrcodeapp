import 'package:flutter/material.dart';

class ShareQrCodePage extends StatelessWidget {
  const ShareQrCodePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        child: Center(
          child: Icon(Icons.share),
        ),
      ),
    );
  }
}
