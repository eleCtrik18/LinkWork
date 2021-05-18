import 'package:demo_app/API%20Services/land_page.dart';
import 'package:demo_app/backup%20of%20home/new_home.dart';
import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  bool firstvalue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    child: Text(
                  "You agree by checking this box",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Container(
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    child: Transform.scale(
                      scale: 2.0,
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
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .45,
            height: MediaQuery.of(context).size.height * .09,
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                "Verify Quarterly Report",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              onPressed: firstvalue ? () => Home() : null,
            ),
          ),
        ],
      ),
    );
  }
}
