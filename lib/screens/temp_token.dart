import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenPage extends StatefulWidget {
  @override
  _TokenPageState createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  var tokenValue = "";
  @override
  void initState() {
    // TODO: implement initState
    fetchToken();
    super.initState();
  }

  void fetchToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var x = pref.getString("token").toString();
    setState(() {
      tokenValue = x;
    });

    //print("Fetch Token Values : " + tokenValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Center(
            child: Column(children: [
          Text('Token Value:'),
          SelectableText(
            '$tokenValue',
            style: TextStyle(fontSize: 18),
          ),
        ])),
      ]),
    );
  }
}
