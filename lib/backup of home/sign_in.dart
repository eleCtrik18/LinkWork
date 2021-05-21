import 'package:demo_app/screens/signup.dart';
import 'package:demo_app/screens/reset_pwd.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
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
            fontSize: 12,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 5, left: 20, bottom: 5),
              hintText: 'Enter your email',
              hintStyle: TextStyle(color: Color(0xffa7a7a7), fontSize: 12)),
        ),
      )
    ],
  );
}

Widget pwd() {
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
          obscureText: true,
          keyboardType: TextInputType.name,
          style: TextStyle(fontSize: 12, color: Colors.black87),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 5, left: 20, bottom: 5),
              hintText: 'Enter your password',
              hintStyle: TextStyle(color: Color(0xFFa7a7a7), fontSize: 12)),
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
    child: ElevatedButton(
      onPressed: () {},
      child: Center(
          child: Text(
        'Sign in',
        style: TextStyle(color: Colors.white, fontSize: 18),
      )),
    ),
  );
}

Widget signin(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
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

class _SignInState extends State<SignIn> {
  bool firstvaluer = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(children: [
              Container(
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
                        EdgeInsets.symmetric(horizontal: 25, vertical: 180),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Sign In',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Welcome to LinkWork - Task Management',
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
                          height: 25,
                        ),
                        pwd(),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 15,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: Checkbox(
                                  value: firstvaluer,
                                  checkColor: Colors.white,
                                  activeColor: Colors.blue,
                                  onChanged: (bool? value1) {
                                    setState(() {
                                      firstvaluer = value1!;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  'Remember Me',
                                  style: TextStyle(color: Color(0xffa7a7a7)),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Password()));
                                  },
                                  child: Text(
                                    "Reset Password",
                                    style: TextStyle(
                                      color: Color(0xFF0176ff),
                                      fontSize: 14,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        finalButtonin(),
                        SizedBox(
                          height: 5,
                        ),
                        signin(context),
                      ],
                    ),
                  ))
            ])));
  }
}
