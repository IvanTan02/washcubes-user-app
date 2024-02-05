import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'CreateOrderPage.dart';

class CreateOrderCameraPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateOrderCameraPageState();
}

class _CreateOrderCameraPageState extends State<CreateOrderCameraPage> {
  Barcode? result;
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR code'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Navigate back to OrderPage
            },
          ),
          IconButton( //temporarily
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateOrderPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Place the QR Code within the frame to scan',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 300,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            SizedBox(height: 20),
            Text('Scanned Data: ${result?.code ?? 'No data yet'}'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
}
