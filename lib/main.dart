import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:qrscan/qrscan.dart' as scanner;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CardPage(title: 'Flutter Demo Home Page'),
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
            child: Text('Scann'),
            onPressed: () async => scannQr(),
          ),
        ),
      ),
    );
  }

  scannQr() async {
    await Permission.camera.request();
    String value = await scanner.scan();
    value = value + '#';
    print(value);
    await launcher.launch('tel:*805*$value');
  }
}
