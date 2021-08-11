import 'package:flutter/cupertino.dart';

class QRCodeState extends ChangeNotifier {
  String _dataQr = "";

  String getDataQr() => _dataQr;

  void setDataQr(String data) {
    _dataQr = data;
    notifyListeners();
  }
}
