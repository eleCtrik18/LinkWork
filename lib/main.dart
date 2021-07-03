// @dart=2.9

import 'dart:io';

import 'package:demo_app/screens/land_page.dart';
import 'package:demo_app/screens/signup.dart';
import 'package:demo_app/utility/connectivity_provider.dart';
import 'package:demo_app/utility/splash.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/login.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', //id
    "Chat Notification", //title
    "This channel is used important notification",
    sound: RawResourceAndroidNotificationSound('arrive'), //desc
    groupId: "Notification_group");

// const AndroidNotificationChannel channel2 = AndroidNotificationChannel(
//     'high_importance_channel2',
//     "High Importance Notifcations2",
//     "This channel is used important notification2",
//     groupId: "chat_group");

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print("Handling a background message : ${message.data}");

  // RemoteNotification notification = message.notification;

  // AndroidNotificationDetails notificationDetails = AndroidNotificationDetails(
  //     channel.id, channel.name, channel.description,
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     icon: "app_icon",
  //     sound: RawResourceAndroidNotificationSound('arrive'),
  //     playSound: true,
  //     groupKey: channel.groupId);
  // NotificationDetails notificationDetailsPlatformSpefics =
  //     NotificationDetails(android: notificationDetails);
  // flutterLocalNotificationsPlugin.show(
  //   notification.hashCode,
  //   notification.title,
  //   notification.body,
  //   notificationDetailsPlatformSpefics,
  // );

  var link = message.data['link'];
  print('Link is $link');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("link", link);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     .createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  var intializationSettingsAndroid = AndroidInitializationSettings("app_icon");
  var initializationSettings =
      InitializationSettings(android: intializationSettingsAndroid);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification?.android;
    if (notification != null && android != null) {
      AndroidNotificationDetails notificationDetails =
          AndroidNotificationDetails(
              channel.id, channel.name, channel.description,
              importance: Importance.max,
              priority: Priority.high,
              icon: "app_icon",
              sound: RawResourceAndroidNotificationSound('arrive'),
              playSound: true,
              groupKey: channel.groupId);
      NotificationDetails notificationDetailsPlatformSpefics =
          NotificationDetails(android: notificationDetails);
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        notificationDetailsPlatformSpefics,
      );
    }
    List<ActiveNotification> activeNotifications =
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.getActiveNotifications();
    if (activeNotifications.length > 0) {
      List<String> lines =
          activeNotifications.map((e) => e.title.toString()).toList();
      InboxStyleInformation inboxStyleInformation = InboxStyleInformation(lines,
          contentTitle: "${activeNotifications.length - 1} messages",
          summaryText: "${activeNotifications.length - 1} messages");
      AndroidNotificationDetails groupNotificationDetails =
          AndroidNotificationDetails(
              channel.id, channel.name, channel.description,
              styleInformation: inboxStyleInformation,
              setAsGroupSummary: true,
              icon: "app_icon",
              sound: RawResourceAndroidNotificationSound('arrive'),
              playSound: true,
              groupKey: channel.groupId);

      NotificationDetails groupNotificationDetailsPlatformSpefics =
          NotificationDetails(android: groupNotificationDetails);
      await flutterLocalNotificationsPlugin.show(
          0, '', '', groupNotificationDetailsPlatformSpefics);
    }
  });

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //   RemoteNotification notification2 = message.notification;
  //   AndroidNotification android = message.notification?.android;
  //   if (notification2 != null && android != null) {
  //     AndroidNotificationDetails notificationDetails2 =
  //         AndroidNotificationDetails(
  //             channel2.id, channel2.name, channel2.description,
  //             importance: Importance.max,
  //             priority: Priority.high,
  //             icon: "app_icon",
  //             groupKey: channel2.groupId);
  //     NotificationDetails notificationDetails2PlatformSpefics =
  //         NotificationDetails(android: notificationDetails2);
  //     flutterLocalNotificationsPlugin.show(
  //         notification2.hashCode,
  //         notification2.title,
  //         notification2.body,
  //         notificationDetails2PlatformSpefics);

  //     print(" Message of Notification 2 $message");
  //   }

  //   List<ActiveNotification> activeNotifications2 =
  //       await flutterLocalNotificationsPlugin
  //           .resolvePlatformSpecificImplementation<
  //               AndroidFlutterLocalNotificationsPlugin>()
  //           ?.getActiveNotifications();
  //   if (activeNotifications2.length > 0) {
  //     List<String> lines =
  //         activeNotifications2.map((e) => e.title.toString()).toList();
  //     InboxStyleInformation inboxStyleInformation = InboxStyleInformation(lines,
  //         contentTitle: "${activeNotifications2.length - 1} messages",
  //         summaryText: "${activeNotifications2.length - 1} messages");
  //     AndroidNotificationDetails groupNotificationDetails2 =
  //         AndroidNotificationDetails(
  //             channel2.id, channel2.name, channel2.description,
  //             styleInformation: inboxStyleInformation,
  //             setAsGroupSummary: true,
  //             icon: "app_icon",
  //             groupKey: channel2.groupId);

  //     NotificationDetails groupNotificationDetails2PlatformSpefics =
  //         NotificationDetails(android: groupNotificationDetails2);
  //     await flutterLocalNotificationsPlugin.show(
  //         0, '', '', groupNotificationDetails2PlatformSpefics);
  //   }
  // });

  FirebaseMessaging.instance.getToken().then((token) async {
    print('Token is $token');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);

    //prefs.setString('token', 'token');
    //var tokenp = SharedPreferences.getInstance()
    // Print the Token in Console
  });

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var email = sharedPreferences.getString('email');
  print(email);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: LandPage(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false, home: MyCustomSplashScreen())));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Future<void> initState() async {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container();
  }
}
// class Helper{

//  static void showNotification();
// }
