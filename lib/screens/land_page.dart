import 'package:connectivity/connectivity.dart';
import 'package:demo_app/utility/connectivity_provider.dart';
import 'package:demo_app/utility/no_internet.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class LandPage extends StatefulWidget {
  @override
  _LandPageState createState() => _LandPageState();
}

class _LandPageState extends State<LandPage> {
  late SharedPreferences sharedPreferences;
  var tokenValue = "";
  var i;
  var e;
  late String url;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    fetchcredentials();

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
  Widget build(BuildContext context) {
    print("BuildLandPage");
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
    return StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder:
            (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
          if (snapshot != null &&
              snapshot.hasData &&
              snapshot.data != ConnectivityResult.none) {
            Container(
                padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
                height: MediaQuery.of(context).size.height / 0.50,
                width: MediaQuery.of(context).size.width / 0.60,
                child: InAppWebView(
                    initialUrl:
                        "https://beta.linkwork.in/Authenticate?id=$i&enc=$e",
                    onWebViewCreated: (InAppWebViewController controller) {
                      print(
                          "https://beta.linkwork.in/Authenticate?id=$i&enc=$e");
                    },
                    onLoadStart:
                        (InAppWebViewController controller, String url) async {
                      print(
                          "on load https://beta.linkwork.in/Authenticate?id=$i&enc=$e");
                      if (url.contains("Logout")) {
                        print('Log Out Success');
                        sharedPreferences.remove("email");
                        sharedPreferences.remove("id");
                        sharedPreferences.remove("enc");

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
                      }
                    }));
          } else if (snapshot.data == ConnectivityResult.none) {
            return NoInternet();
          }
          return Container(
              padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
              height: MediaQuery.of(context).size.height / 0.50,
              width: MediaQuery.of(context).size.width / 0.60,
              child: InAppWebView(
                  initialUrl:
                      "https://beta.linkwork.in/Authenticate?id=$i&enc=$e",
                  onWebViewCreated: (InAppWebViewController controller) {
                    print("https://beta.linkwork.in/Authenticate?id=$i&enc=$e");
                  },
                  onLoadStart:
                      (InAppWebViewController controller, String url) async {
                    print(
                        "on load https://beta.linkwork.in/Authenticate?id=$i&enc=$e");
                    if (url.contains("Logout")) {
                      print('Log Out Success');
                      sharedPreferences.remove("email");
                      sharedPreferences.remove("id");
                      sharedPreferences.remove("enc");

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
                    }
                  }));
        });
  }
}
