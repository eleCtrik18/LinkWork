import 'dart:convert';

import 'package:demo_app/screens/reset_pwd.dart';
import 'package:demo_app/utility/connectivity_provider.dart';
import 'package:demo_app/utility/no_internet.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'package:http/http.dart' as http;

class LandPage extends StatefulWidget {
  @override
  _LandPageState createState() => _LandPageState();
}

class _LandPageState extends State<LandPage> {
  late SharedPreferences sharedPreferences;
  var tokenValue = "";
  var e;
  var p;
  late String url;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    fetchcredentials();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android!;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  void fetchcredentials() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      e = pref.getString('email').toString();
      p = pref.getString('pass').toString();
    });
    print("Email value : " + e);
    print("Password Value : " + p);
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("id") == null) {
      print('Logged out');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: scaffoldKey,

        // appBar: AppBar(
        //   backgroundColor: Color(0xffffffff),
        //   title: Text("LinkWork", style: TextStyle(color: Colors.black87)),
        //   centerTitle: true,
        //   actions: <Widget>[
        //     // ignore: deprecated_member_use
        //     // FlatButton(
        //     //   onPressed: () {
        //     //     sharedPreferences.remove("email");
        //     //     // ignore: deprecated_member_use
        //     //     sharedPreferences.commit();
        //     //     Navigator.of(context).pushAndRemoveUntil(
        //     //         MaterialPageRoute(
        //     //             builder: (BuildContext context) => LoginPage()),
        //     //         (Route<dynamic> route) => false);
        //     //   },
        //     //  // child: Text("Log Out", style: TextStyle(color: Colors.black87)),
        //     // ),
        //   ],
        // ),
        body: pageUI(),
      ),
    );
  }

  Future<bool> onWillPop() async {
    final shouldPop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Are you sure you want to exit the app?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }

  Widget pageUI() {
    return Consumer<ConnectivityProvider>(
        builder: (consumerContext, model, child) {
      if (model.isOnline != null) {
        return model.isOnline
            ? Container(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                height: 900,
                width: MediaQuery.of(context).size.width / 0.60,
                child: InAppWebView(
                    // initialUrl: "https://www.google.com.pk/",
                    initialUrl:
                        "https://beta.linkwork.in/Authenticate?id=2&enc=ef52f0c009bdbc905292c79b3f634ebe",
                    onWebViewCreated: (InAppWebViewController controller) {},
                    onLoadStart:
                        (InAppWebViewController controller, String url) async {
                      if (url.contains("Logout")) {
                        print('Log Out Success');
                        sharedPreferences.remove("email");
                        // ignore: deprecated_member_use
                        sharedPreferences.commit();
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => LoginPage(),
                            transitionsBuilder: (c, anim, a2, child) =>
                                FadeTransition(opacity: anim, child: child),
                            transitionDuration: Duration(milliseconds: 300),
                          ),
                        );
                      }
                    }))
            : NoInternet();
      }
      return Container(
          child: Center(
        child: CircularProgressIndicator(),
      ));
    });
  }
}
