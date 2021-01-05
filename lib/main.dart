import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CardPage(title: 'Card QR Scanner'),
    );
  }
}

class CardPage extends StatefulWidget {
  CardPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  void initState() {
    scannQr();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Center(
          child: FlatButton(
            child: Text('Scan'),
            color: Colors.green,
            onPressed: () async => scannQr(),
          ),
        ),
      ),
    );
  }

  scannQr() async {
    await Permission.camera.request();
    String value = await scanner.scan().catchError((e) {
      Fluttertoast.showToast(msg: 'No Number found');
    });
    await launcher.launch('tel:' + Uri.encodeComponent('*805*$value#'));
  }
}
