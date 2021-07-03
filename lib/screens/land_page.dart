import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:demo_app/screens/chat_box.dart';
import 'package:demo_app/utility/connectivity_provider.dart';
import 'package:demo_app/utility/no_internet.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class LandPage extends StatefulWidget {
  @override
  _LandPageState createState() => _LandPageState();
}

class _LandPageState extends State<LandPage> {
  var linkValue = "";
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  late StreamSubscription<String> _onUrlChanged;
  final _history = [];
  late SharedPreferences sharedPreferences;
  var tokenValue = "";
  var i;
  var e;

  String logouturl = 'https://beta.linkwork.in/Logout';
  @override
  void initState() {
    super.initState();

    flutterWebViewPlugin.close();
    fetchlink();

    fetchcredentials();
    checkLoginStatus();
    // This Commented part was onTap Notification 
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    //   print('On Tap Function Invoked');
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     print('Works fine');
    //     print('Linkvalue is $linkValue');
    //     Container(
    //         child: WebviewScaffold(
    //       url: "$linkValue",
    //       //         // initialUrl: "https://www.google.com",
    //     ));
    //     // showDialog(
    //     //     context: context,
    //     //     builder: (_) {
    //     //       print("Linkvalue is $linkValue");
    //     //       return InAppWebView(
    //     //         initialUrl: "$linkValue",
    //     //         // initialUrl: "https://www.google.com",
    //     //       );
    //     //     });
    //   }
    // }
    

    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (url.contains('Logout')) {
        setState(() async {
          _history.add('onUrlChanged: $logouturl');
          sharedPreferences.remove("email");
          sharedPreferences.remove("id");
          sharedPreferences.remove("enc");
          print(url);

          // ignore: deprecated_member_use
          sharedPreferences.commit();
          await Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => LoginPage(),
              transitionsBuilder: (c, anim, a2, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
          final snackBar = SnackBar(content: Text('Logged Out'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print("Logout Done");
        });
      }
      if (url.contains('Logout')) {
        setState(() async {
          _history.add('onUrlChanged: $logouturl');
          sharedPreferences.remove("email");
          sharedPreferences.remove("id");
          sharedPreferences.remove("enc");
          print(url);

          // ignore: deprecated_member_use
          sharedPreferences.commit();
          await Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => LoginPage(),
              transitionsBuilder: (c, anim, a2, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
          final snackBar = SnackBar(content: Text('Logged Out'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print("Logout Done");
        });
      }
      if (url.contains("portal_files")) {
        launch(url);
        print("FOUND DOWNLOADABLE CONTENT");
      }
    });
  }

  void fetchlink() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var l = pref.getString("link").toString();
    setState(() {
      linkValue = l;
      print("LinkValue OG is $linkValue");
    });
  }

  void fetchcredentials() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      i = pref.getString('id').toString();
      e = pref.getString('enc').toString();
    });

    print("id : " + i);
    print("enc : " + e);
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
  void dispose() {
    _onUrlChanged.cancel();

    flutterWebViewPlugin.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("BuildLandPage");
    return WillPopScope(
        onWillPop: () => onWillPop(),
        child: Scaffold(
            key: scaffoldKey,
            // appBar: AppBar(
            //   backgroundColor: Color(0xffffffff),
            //   title: Text("LinkWork", style: TextStyle(color: Colors.black87)),
            //   centerTitle: true,
            //   actions: <Widget>[
            //     FlatButton(
            //       onPressed: () {
            //         sharedPreferences.remove("email");
            //         // ignore: deprecated_member_use
            //         sharedPreferences.commit();
            //         Navigator.of(context).pushAndRemoveUntil(
            //             MaterialPageRoute(
            //                 builder: (BuildContext context) => LoginPage()),
            //             (Route<dynamic> route) => false);
            //       },
            //       // child: Text("Log Out", style: TextStyle(color: Colors.black87)),
            //     ),
            //   ],
            // ),
            body: StreamBuilder(
                stream: Connectivity().onConnectivityChanged,
                builder: (BuildContext context,
                    AsyncSnapshot<ConnectivityResult> snapshot) {
                  if (snapshot != null &&
                      snapshot.hasData &&
                      snapshot.data != ConnectivityResult.none) {
                    return Container(
                      padding: EdgeInsets.fromLTRB(0, 35, 0, 0),
                      height: MediaQuery.of(context).size.height / 0.50,
                      width: MediaQuery.of(context).size.width / 0.60,
                      child: WebviewScaffold(
                          url:
                              "https://beta.linkwork.in/Authenticate?id=$i&enc=$e"),
                    );
                  } else if (snapshot.data == ConnectivityResult.none) {
                    return NoInternet();
                  }
                  return Container(
                      padding: EdgeInsets.fromLTRB(0, 35, 0, 0),
                      height: MediaQuery.of(context).size.height / 0.50,
                      width: MediaQuery.of(context).size.width / 0.60,
                      child: WebviewScaffold(
                          url:
                              "https://beta.linkwork.in/Authenticate?id=$i&enc=$e")
                    
                      );
                })));
  }

  Future<bool> onWillPop() async {
    print("Dialog");
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
}
