import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'State/qr_code_state.dart';
import 'constraints.dart';

class CreateQrCodePage extends StatelessWidget {
  const CreateQrCodePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final String dataQrCode = "";
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QRCodeState(),
      child: Consumer<QRCodeState>(
        builder: (context, qrcodestate, _) => Center(
          child: Scaffold(
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
            backgroundColor: kBackgroundColorMain,
            body: Container(
              height: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  QrImage(
                    data: qrcodestate.getDataQr(),
                    size: 200,
                  ),
                  InputTextForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InputTextForm extends StatefulWidget {
  @override
  _InputTextFormState createState() => _InputTextFormState();
}

class _InputTextFormState extends State<InputTextForm> {
  final inputTextFormController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputTextFormController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final qrcodestate = Provider.of<QRCodeState>(context);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextFormField(
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              qrcodestate.setDataQr(inputTextFormController.text);
              print(inputTextFormController.value);
            },
            icon: Icon(Icons.send),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          labelText: "Qr Code Data",
        ),
        controller: inputTextFormController,
      ),
    );
  }
}
