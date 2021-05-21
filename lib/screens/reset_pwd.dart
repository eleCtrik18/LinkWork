import 'package:demo_app/screens/signup.dart';
import 'package:demo_app/backup%20of%20home/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

Widget emailID() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xffedeef6),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 0, offset: Offset(0, 0))
            ]),
        height: 50,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 5, left: 20, bottom: 5),
              hintText: 'Enter your email',
              hintStyle: TextStyle(color: Color(0xffa7a7a7), fontSize: 14)),
        ),
      )
    ],
  );
}

Widget finalButtonin() {
  return Container(
    height: 80,
    padding: EdgeInsets.symmetric(vertical: 15),
    width: double.infinity,
    child: GestureDetector(
      onTap: () {},
      child: ElevatedButton(
        onPressed: () {},
        child: Center(
            child: Text(
          'Recover my Password',
          style: TextStyle(color: Colors.white, fontSize: 18),
        )),
      ),
    ),
  );
}

Widget signinr(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => SignIn(),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 220),
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
                          emailID(),
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
            ])));
  }
}
