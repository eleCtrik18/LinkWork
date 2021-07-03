// // @dart=2.9

// import 'package:demo_app/screens/land_page.dart';
// import 'package:demo_app/screens/signup.dart';
// import 'package:demo_app/utility/connectivity_provider.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'screens/login.dart';

// // const AndroidNotificationChannel channel = AndroidNotificationChannel(
// //   'high_importance_channel', // id
// //   'High Importance Notifications', // title
// //   'This channel is used for important notifications.', // description
// //   groupId: "com.android.example.WORK_EMAIL",
// //   //importance: Importance.high,
// //   //playSound: true);
// // );
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('A bg message just showed up :  ${message.messageId}');
// }

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   // await flutterLocalNotificationsPlugin
//   //     .resolvePlatformSpecificImplementation<
//   //         AndroidFlutterLocalNotificationsPlugin>()
//   //     ?.createNotificationChannel();

//   FirebaseMessaging.instance.getToken().then((token) async {
//     print('Token is $token');
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString("token", token);

//     //prefs.setString('token', 'token');
//     //var tokenp = SharedPreferences.getInstance()
//     // Print the Token in Console
//   });

//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   var email = sharedPreferences.getString('email');
//   print(email);
//   runApp(MultiProvider(providers: [
//     ChangeNotifierProvider(
//       create: (context) => ConnectivityProvider(),
//       child: LandPage(),
//     )
//   ], child: MaterialApp(debugShowCheckedModeBanner: false, home: LandPage())));
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   void initState() {
//     super.initState();
//     var intializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettings =
//         InitializationSettings(android: intializationSettingsAndroid);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       RemoteNotification notification = message.notification;
//       AndroidNotification android = message.notification?.android;
//       if (notification != null && android != null) {
//         AndroidNotificationDetails notificationDetails =
//             AndroidNotificationDetails("test_channel", "THis is a test",
//                 "THis is a test test description",
//                 importance: Importance.max,
//                 priority: Priority.high,
//                 groupKey: "com.example.demo_app");
//         NotificationDetails notificationDetailsPlatformSpefics =
//             NotificationDetails(android: notificationDetails);
//         flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             notificationDetailsPlatformSpefics);
//       }
//       List<ActiveNotification> activeNotifications =
//           await flutterLocalNotificationsPlugin
//               .resolvePlatformSpecificImplementation<
//                   AndroidFlutterLocalNotificationsPlugin>()
//               ?.getActiveNotifications();
//       if (activeNotifications.length > 0) {
//         List<String> lines =
//             activeNotifications.map((e) => e.title.toString()).toList();
//         InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
//             lines,
//             contentTitle: "${activeNotifications.length - 1} messages",
//             summaryText: "${activeNotifications.length - 1} messages");
//         AndroidNotificationDetails groupNotificationDetails =
//             AndroidNotificationDetails("test_channel", "THis is a test",
//                 "THis is a test test description",
//                 styleInformation: inboxStyleInformation,
//                 setAsGroupSummary: true,
//                 groupKey: "com.example.demo_app");

//         NotificationDetails groupNotificationDetailsPlatformSpefics =
//             NotificationDetails(android: groupNotificationDetails);
//         await flutterLocalNotificationsPlugin.show(
//             0, '', '', groupNotificationDetailsPlatformSpefics);
//       }
//     });
//   }

//   // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//   //   print('A new onMessageOpenedApp event was published!');
//   //   RemoteNotification notification = message.notification;
//   //   AndroidNotification android = message.notification?.android;
//   //   if (notification != null && android != null) {
//   //     showDialog(
//   //         context: context,
//   //         builder: (_) {
//   //           return AlertDialog(
//   //             title: Text(notification.title),
//   //             content: SingleChildScrollView(
//   //               child: Column(
//   //                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                 children: [Text(notification.body)],
//   //               ),
//   //             ),
//   //           );
//   //         });
//   //   }
//   // });

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Container();
//   }
// }
// //
