import 'dart:convert';

import 'package:demo_app/screens/login.dart';
import 'package:demo_app/screens/signup.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

// Widget emailID() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Container(
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//             color: Color(0xffedeef6),
//             borderRadius: BorderRadius.circular(6),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.black26, blurRadius: 0, offset: Offset(0, 0))
//             ]),
//         height: 50,
//         child: TextField(
//           keyboardType: TextInputType.emailAddress,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.black87,
//           ),
//           decoration: InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(top: 5, left: 20, bottom: 5),
//               hintText: 'Enter your email',
//               hintStyle: TextStyle(color: Color(0xffa7a7a7), fontSize: 14)),
//         ),
//       )
//     ],
//   );
// }

Widget signinr(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => LoginPage(),
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 300),
        ),
      );
    },
    child: RichText(
      text: TextSpan(children: [
        TextSpan(
            text: "Remembered Your Password? ",
            style: TextStyle(
                color: Color(0xffa7a7a7),
                fontSize: 14,
                fontWeight: FontWeight.w500)),
        TextSpan(
            text: 'Sign in',
            style: TextStyle(color: Color(0xff0176ff), fontSize: 14))
      ]),
    ),
  );
}

Widget signupr(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => Home(),
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 300),
        ),
      );
    },
    child: RichText(
      text: TextSpan(children: [
        TextSpan(
            text: "Don't have an account yet ",
            style: TextStyle(
                color: Color(0xffa7a7a7),
                fontSize: 14,
                fontWeight: FontWeight.w500)),
        TextSpan(
            text: 'Sign up',
            style: TextStyle(color: Color(0xff0176ff), fontSize: 14))
      ]),
    ),
  );
}

class _PasswordState extends State<Password> {
  final GlobalKey<FormState> _recKey = GlobalKey<FormState>();
  void validaterecovery() async {
    if (_recKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      //showLoaderDialog(context);
      // fbtoken('$id');

      recover(emailrController.text);

      return;
    } else {
      print("UnSuccessfull");
    }
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildbody());
  }

  final TextEditingController emailrController = new TextEditingController();

  Widget buildbody() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffFFFFFF),
                      Color(0xffFFFFFF),
                      Color(0xffFFFFFF),
                      Color(0xffFFFFFF),
                    ]),
              ),
              child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 220),
                  child: Column(
                    children: [
                      Text(
                        'Recovery',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Forgot Your Password?',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      emailId(),
                      SizedBox(
                        height: 15,
                      ),
                      finalButtonin(),
                      SizedBox(
                        height: 15,
                      ),
                      signupr(context),
                      SizedBox(
                        height: 13,
                      ),
                      signinr(context)
                    ],
                  )))
        ]));
  }

  Widget finalButtonin() {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          validaterecovery();
        },
        child: Center(
            child: Text(
          'Recover my Password',
          style: TextStyle(color: Colors.white, fontSize: 18),
        )),
      ),
    );
  }

  Container emailId() {
    return Container(
      child: Form(
        key: _recKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xffedeef6),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 0,
                        offset: Offset(0, 0))
                  ]),
              height: 50,
              child: TextFormField(
                // autovalidate: true,
                controller: emailrController,
                autofillHints: [AutofillHints.email],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 5, left: 20, bottom: 5),
                    hintText: 'Enter your Email',
                    hintStyle:
                        TextStyle(color: Color(0xffa7a7a7), fontSize: 12)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Email';
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return 'Please enter valid Email';
                  }

                  return null;
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  recover(String email) async {
    Map data = {
      'email': email,
      'enc': 'b26ce731026c8ed318a609a821737f2bd3442357cc6fafe3bfd3268084a135bb',
    };
    print(data);
    var jsonResponse;

    var response = await http.post(
        Uri.parse(
          "https://www.linkwork.in/app_api/recover.php",
        ),
        body: data);
    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 400) {
      jsonResponse = json.decode(response.body);

      if (jsonResponse['status'] == 'Success') {
        setState(() {
          _isLoading = false;
          final snackBar =
              SnackBar(content: Text('Recovery Email has been sent'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
      if (jsonResponse['status'] == 'Removed') {
        setState(() {
          _isLoading = false;
        });
        final snackBar = SnackBar(content: Text('User has been removed'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (jsonResponse['status'] == 'Failed') {
        setState(() {
          _isLoading = false;
        });
        final snackBar = SnackBar(content: Text('Email not found'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (jsonResponse['status'] == 'Invalid') {
        setState(() {
          _isLoading = false;
        });
        final snackBar = SnackBar(content: Text('Token Error Contact Support'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        setState(() {
          _isLoading = false;
          print("Snackbar");
        });
      }
    }
  }
}
