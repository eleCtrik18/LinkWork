import 'dart:convert';

import 'package:checkbox_formfield/checkbox_icon_formfield.dart';
import 'package:checkbox_formfield/checkbox_list_tile_formfield.dart';
import 'package:demo_app/screens/login.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wc_form_validators/wc_form_validators.dart';

import 'land_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

Widget signup(BuildContext context) {
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
  final GlobalKey<FormState> _checkKey = GlobalKey<FormState>();

  void validate() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      if (_checkKey.currentState!.validate()) {
        print('Check function if');
        _checkKey.currentState!.save();
        signupapi(
            companyController.text,
            nameController.text,
            genderController.text,
            emailupController.text,
            phoneController.text,
            passwordupController.text,
            repasswordupController.text,
            referralController.text);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', 'useremail@');
      }

      //showLoaderDialog(context);
      else {
        print('Check');
      }
    } else {
      print("UnSuccessfull");
    }
  }

  bool _isLoading = false;
  bool checkboxValue = false;

  String? valChoose;
  List<String> listItem = ['Male', 'Female', 'Others'];
  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now().add(Duration(days: 14));
    String formatter = DateFormat('dd-MM-y').format(now);

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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
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
                          height: 15,
                        ),
                        signuptextSection(),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
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
                          height: 25,
                        ),
                        checkboxup(),
                        SizedBox(
                          height: 15,
                        ),
                        signupbuttonSection(),
                        SizedBox(
                          height: 20,
                        ),
                        signup(context),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }

  signupapi(String companyName, personName, gender, email, mobile, pass, rpass,
      referral) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'company_name': companyName,
      'person_name': personName,
      'gender': valChoose,
      'email': email,
      'mobile': mobile,
      'pass': pass,
      'rpass': rpass,
      'referral': referral,
      'enc': "b26ce731026c8ed318a609a821737f2bd3442357cc6fafe3bfd3268084a135bb",
    };
    print(data);
    var jsonResponse;

    http.Response response = await http.post(
        Uri.parse(
          "https://www.linkwork.in/app_api/Signup",
        ),
        body: data);
    print(response.body);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      if (jsonResponse['status'] == '0') {
        setState(() {
          _isLoading = false;
        });
        final snackBar = SnackBar(content: Text('User Already Registered'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      if (jsonResponse['status'] == 'Invalid Request') {
        setState(() {
          _isLoading = false;
        });
        final snackBar = SnackBar(content: Text('Please Contact Support'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      if (jsonResponse['status'] == '1') {
        setState(() {
          _isLoading = false;
        });
        final snackBar = SnackBar(
          content: Text('Registration Succesfull!'),
          action: SnackBarAction(
            label: 'Sign In',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    // if (jsonResponse != null) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   sharedPreferences.setString("enc", jsonResponse['enc']);
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(builder: (BuildContext context) => LandPage()),
    //       (Route<dynamic> route) => false);

    else {
      setState(() {
        _isLoading = false;
      });
      print(" Something went Wrong");
    }
  }

  Container signupbuttonSection() {
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
        child: Text("Create an account",
            style: TextStyle(color: Colors.white, fontSize: 18)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController companyController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailupController = new TextEditingController();
  final TextEditingController genderController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passwordupController =
      new TextEditingController();
  final TextEditingController repasswordupController =
      new TextEditingController();
  final TextEditingController referralController = new TextEditingController();

  Container signuptextSection() {
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
                controller: companyController,
                // autovalidate: true,

                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 5, left: 20, bottom: 5),
                    hintText: 'Enter your Company Name',
                    hintStyle:
                        TextStyle(color: Color(0xffa7a7a7), fontSize: 14)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Can't be empty";
                  }

                  if (!RegExp(r"^[A-Za-z' ]+$").hasMatch(value)) {
                    return 'Name field should contain alphabets only';
                  }
                },
              ),
            ),
            SizedBox(height: 15),
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
                controller: nameController,
                keyboardType: TextInputType.name,
                style: TextStyle(fontSize: 14, color: Colors.black87),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 5, left: 20, bottom: 5),
                    hintText: 'Enter your name',
                    hintStyle:
                        TextStyle(color: Color(0xFFa7a7a7), fontSize: 14)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Can't be empty";
                  }

                  if (!RegExp(r"^[A-Za-z ]+$").hasMatch(value)) {
                    return 'Name field should contain alphabets only';
                  }
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
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
              // child: TextFormField(
              //   controller: genderController,
              //   keyboardType: TextInputType.name,
              //   style: TextStyle(fontSize: 14, color: Colors.black87),
              //   decoration: InputDecoration(
              //       border: InputBorder.none,
              //       contentPadding:
              //           EdgeInsets.only(top: 5, left: 20, bottom: 5),
              //       hintText: 'Enter your gender (Male),(Female),(Other)',
              //       hintStyle:
              //           TextStyle(color: Color(0xFFa7a7a7), fontSize: 14)),
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return "Can't be empty";
              //     } else if (!RegExp(r"^[MmaleFfemaleOothers]")
              //         .hasMatch(value)) {
              //       return 'Enter a valid Gender';
              //     }
              //   },
              // ),
              child: Container(
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
                      style: TextStyle(color: Color(0xffa7a7a7), fontSize: 14),
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
                        print(valChoose);
                      });
                    },
                    items: listItem.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList()),
              ),
            ),
            SizedBox(
              height: 15,
            ),
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
                controller: emailupController,
                autofillHints: [AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: 14, color: Colors.black87),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 5, left: 20, bottom: 5),
                    hintText: 'Enter your email',
                    hintStyle:
                        TextStyle(color: Color(0xFFa7a7a7), fontSize: 14)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Can't be empty";
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return 'Please enter a valid Email';
                  }
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
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
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.only(top: 5, left: 20, bottom: 5),
                      hintText: "Enter your mobile number",
                      hintStyle:
                          TextStyle(color: Color(0xFFa7a7a7), fontSize: 14)),
                  validator: (phone) {
                    if (phone!.isEmpty) {
                      return 'Please Enter mobile number';
                    } else if (phone.length < 10) {
                      return 'Enter 10 digit number';
                    } else if (phone.length > 10) {
                      return 'Please enter 10 digit';
                    } else
                      return null;
                  }),
            ),
            SizedBox(
              height: 15,
            ),
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
                controller: passwordupController,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(fontSize: 14, color: Colors.black87),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 5, left: 20, bottom: 5),
                    hintText: 'Enter your password',
                    hintStyle:
                        TextStyle(color: Color(0xFFa7a7a7), fontSize: 14)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Required';
                  }

                  return null;
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
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
                controller: repasswordupController,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(fontSize: 14, color: Colors.black87),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 5, left: 20, bottom: 5),
                    hintText: 'Re-Enter your Password',
                    hintStyle:
                        TextStyle(color: Color(0xFFa7a7a7), fontSize: 14)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Required';
                  }
                  if (value != passwordupController.text)
                    return 'Passwords Do not match';
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
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
                controller: referralController,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(fontSize: 12, color: Colors.black87),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 5, left: 20, bottom: 5),
                    hintText: 'Referral Code, if available. (optional)',
                    hintStyle:
                        TextStyle(color: Color(0xFFa7a7a7), fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget checkboxup() {
    return Form(
      key: _checkKey,
      child: ListTileTheme(
        contentPadding: EdgeInsets.all(0),
        child: CheckboxListTileFormField(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text('I agree the terms and conditions',
              style: TextStyle(fontSize: 16, color: Color(0xffa7a7a7))),
          // onSaved: (bool value) {},

          validator: (bool value) {
            print(value.toString() + "Before if");
            if (value == false) {
              print(value);
              return 'Please accept Terms and Condition';
            } else {
              print(value);
              return null;
            }
          },
        ),
      ),
    );
  }
}
