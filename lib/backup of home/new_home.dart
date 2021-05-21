import 'dart:convert';

import 'package:demo_app/screens/login.dart';
import 'package:http/http.dart' as http;

import 'package:demo_app/backup%20of%20home/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

Widget buildCompany() {
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
                  color: Colors.black, blurRadius: 0, offset: Offset(0, 0))
            ]),
        height: 50,
        child: TextField(
          keyboardType: TextInputType.name,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 5, left: 20, bottom: 5),
              hintText: 'Enter your company name',
              hintStyle: TextStyle(color: Color(0xFFa7a7a7), fontSize: 14)),
        ),
      )
    ],
  );
}

Widget buildName() {
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
          keyboardType: TextInputType.name,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 5, left: 20, bottom: 5),
              hintText: 'Enter your name',
              hintStyle: TextStyle(color: Color(0xffa7a7a7), fontSize: 14)),
        ),
      )
    ],
  );
}

Widget buildEmail() {
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
              hintStyle: TextStyle(color: Color(0xFFa7a7a7), fontSize: 14)),
        ),
      )
    ],
  );
}

Widget buildNumber() {
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
          keyboardType: TextInputType.phone,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 5, left: 20, bottom: 5),
              hintText: 'Enter your mobile number',
              hintStyle: TextStyle(color: Color(0xffa7a7a7), fontSize: 14)),
        ),
      )
    ],
  );
}

Widget buildPass() {
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
          keyboardType: TextInputType.visiblePassword,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 5, left: 20, bottom: 5),
              hintText: 'Enter your password',
              hintStyle: TextStyle(color: Color(0xffa7a7a7), fontSize: 14)),
        ),
      )
    ],
  );
}

Widget buildRpass() {
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
          keyboardType: TextInputType.visiblePassword,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 5, left: 20, bottom: 5),
              hintText: 'Re-Enter your password',
              hintStyle: TextStyle(color: Color(0xffa7a7a7), fontSize: 14)),
        ),
      )
    ],
  );
}

Widget finalButton() {
  return Container(
    height: 80,
    padding: EdgeInsets.symmetric(vertical: 15),
    width: double.infinity,
    child: GestureDetector(
      onTap: () {},
      child: ElevatedButton(
        style: ButtonStyle(),
        onPressed: () {},
        child: Center(
            child: Text(
          'Create an account',
          style: TextStyle(color: Colors.white, fontSize: 18),
        )),
      ),
    ),
  );
}

Widget signup(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    },
    child: RichText(
      text: TextSpan(children: [
        TextSpan(
            text: 'Already have an account ?',
            style: TextStyle(
                color: Color(0xffa7a7a7),
                fontSize: 14,
                fontWeight: FontWeight.w500)),
        TextSpan(
            text: ' Sign in',
            style: TextStyle(color: Color(0xff0176ff), fontSize: 14))
      ]),
    ),
  );
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool firstvalue = false;
  bool secondvalue = false;
  String? valChoose;
  List listItem = ['Male', 'Female', 'Others'];
  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now().add(Duration(days: 14));
    String formatter = DateFormat('d-MM-y').format(now);

    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(
              children: [
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
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 45),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Welcome to LinkWork.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        buildCompany(),
                        SizedBox(
                          height: 25,
                        ),
                        buildName(),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 14),
                          decoration: BoxDecoration(
                              color: Color(0xffedeef6),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 0,
                                    offset: Offset(0, 0))
                              ]),
                          child: DropdownButton(
                              hint: Text(
                                'Male',
                                style: TextStyle(
                                    color: Color(0xffa7a7a7), fontSize: 12),
                              ),
                              dropdownColor: Colors.grey[400],
                              icon: Icon(Icons.arrow_drop_down),
                              isExpanded: true,
                              style: TextStyle(color: Colors.black87),
                              underline: SizedBox(),
                              value: valChoose,
                              onChanged: (newValue) {
                                setState(() {
                                  valChoose = newValue as String?;
                                });
                              },
                              items: listItem.map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(valueItem),
                                );
                              }).toList()),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        buildEmail(),
                        SizedBox(
                          height: 25,
                        ),
                        buildNumber(),
                        SizedBox(
                          height: 25,
                        ),
                        buildPass(),
                        SizedBox(
                          height: 25,
                        ),
                        buildRpass(),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            margin: EdgeInsets.only(right: 60),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Text(
                                      'Free Trial Till - ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffa7a7a7)),
                                    ),
                                    Text(
                                      formatter.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffa7a7a7)),
                                    ),
                                  ]),
                                ])),
                        SizedBox(
                          height: 13,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 15,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 15,
                                child: Checkbox(
                                  value: firstvalue,
                                  checkColor: Colors.white,
                                  activeColor: Colors.blue,
                                  onChanged: (bool? value1) {
                                    setState(() {
                                      firstvalue = value1!;
                                    });
                                  },
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(6)),
                              Text(
                                'I agree the Terms and Conditions',
                                style: TextStyle(color: Color(0xffa7a7a7)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        finalButton(),
                        SizedBox(
                          height: 10,
                        ),
                        signup(context),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
