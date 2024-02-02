import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CreateOrderCameraPage extends StatefulWidget {
  @override
  _CreateOrderCameraPageState createState() => _CreateOrderCameraPageState();
}

class _CreateOrderCameraPageState extends State<CreateOrderCameraPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Text('Place the QR Code within the frame to scan'),
          ElevatedButton(
            onPressed: _turnOnLight,
            child: Text('Tap to turn light on'),
          ),
        ],
      ),
    );
  }

  void _turnOnLight() {
    controller?.toggleFlash();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
