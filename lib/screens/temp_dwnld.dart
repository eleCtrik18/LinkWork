// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await FlutterDownloader.initialize(
//       debug: true // optional: set false to disable printing logs to console
//       );
//   await Permission.storage.request();
//   runApp(new MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => new _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late InAppWebViewController webView;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('InAppWebView Example'),
//         ),
//         body: Container(
//             child: Column(children: <Widget>[
//           Expanded(
//               child: InAppWebView(
//             initialUrl: "http://ovh.net/files/1Mio.dat",
//             initialHeaders: {},
//             initialOptions: InAppWebViewGroupOptions(
//               crossPlatform: InAppWebViewOptions(
//                   debuggingEnabled: true, useOnDownloadStart: true),
//             ),
//             onWebViewCreated: (InAppWebViewController controller) {
//               webView = controller;
//             },
//             onLoadStart: (InAppWebViewController controller, String url) {},
//             onLoadStop: (InAppWebViewController controller, String url) {},
//             onDownloadStart: (controller, url) async {
//               print("onDownloadStart $url");
//               final taskId = await FlutterDownloader.enqueue(
//                 url: url,
//                 savedDir: (await getExternalStorageDirectory())!.path,
//                 showNotification:
//                     true, // show download progress in status bar (for Android)
//                 openFileFromNotification:
//                     true, // click on notification to open downloaded file (for Android)
//               );
//             },
//           ))
//         ])),
//       ),
//     );
//   }
// }
