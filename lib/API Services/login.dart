import 'dart:convert';

import 'package:demo_app/home.dart';
import 'package:demo_app/reset_pwd.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import 'land_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
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

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void validate() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      //showLoaderDialog(context);
      signIn(emailController.text, passwordController.text);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', 'useremail@');
      return;
    } else {
      print("UnSuccessfull");
    }
  }

  // void validateAndSave() async {
  //   final form = _formKey.currentState;
  //   if (form!.validate()) {
  //     print('Form is valid');
  //   } else {
  //     print('form is invalid');
  //   }
  // }

  bool _isLoading = false;
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
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 180),
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
                          textSection(),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 50,
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Password()));
                                    },
                                    child: SizedBox(
                                      height: 20,
                                      width: 120,
                                      child: Text(
                                        "Reset Password",
                                        style: TextStyle(
                                          color: Color(0xFF0176ff),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          buttonSection(),
                          SizedBox(
                            height: 5,
                          ),
                          signin(context),
                        ]),
                  ),
          )
        ]),
      ),
    );
  }

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email': email,
      'pass': pass,
      'enc': 'b26ce731026c8ed318a609a821737f2bd3442357cc6fafe3bfd3268084a135bb'
    };
    print(data);
    var jsonResponse = null;

    var response = await http.post(
        Uri.parse(
          "https://www.linkwork.in/app_api/Login",
        ),
        body: data);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("id", jsonResponse['id']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => LandPage()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print("Wrong");
    }
  }

  Container buttonSection() {
    return Container(
      width: double.infinity,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: () {
          validate();
        },
        // onPressed: emailController.text == "" || passwordController.text == ""
        //     ? null
        //     : () async {
        //         setState(() {
        //           _isLoading = true;
        //         });

        //         signIn(emailController.text, passwordController.text);
        //         SharedPreferences prefs = await SharedPreferences.getInstance();
        //         prefs.setString('email', 'useremail@');

        elevation: 0.0,
        color: Colors.blue[400],
        child: Text("Sign In",
            style: TextStyle(color: Colors.white70, fontSize: 18)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Form(
        key: _formKey,
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
                controller: emailController,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 5, left: 20, bottom: 5),
                    hintText: 'Enter your email',
                    hintStyle:
                        TextStyle(color: Color(0xffa7a7a7), fontSize: 12)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Email';
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return 'Please Enter valid Email';
                  }

                  return null;
                },
              ),
            ),
            SizedBox(height: 25),
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
                controller: passwordController,
                obscureText: true,
                keyboardType: TextInputType.name,
                style: TextStyle(fontSize: 12, color: Colors.black87),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 5, left: 20, bottom: 5),
                    hintText: 'Enter your password',
                    hintStyle:
                        TextStyle(color: Color(0xFFa7a7a7), fontSize: 12)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter required field Password';
                  }

                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}