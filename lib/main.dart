import 'package:demo_app/API%20Services/land_page.dart';
import 'package:demo_app/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'API Services/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var email = sharedPreferences.getString('email');
  print(email);
  runApp(MaterialApp(home: email == null ? LoginPage() : LandPage()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final bool disableButton = true;
    return MaterialApp(
      title: 'Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: LoginPage(),
    );
  }
}
