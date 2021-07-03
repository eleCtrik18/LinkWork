import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Chatpage extends StatefulWidget {
  @override
  _ChatpageState createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        height: 900,
        width: MediaQuery.of(context).size.width / 0.60,
        child: Container(
          alignment: Alignment.center,
          child: Text('Notification Page'),
        ));
  }
}
