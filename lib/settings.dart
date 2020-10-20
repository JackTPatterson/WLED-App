import 'package:flutter/material.dart';
import 'package:wled/infoPage.dart';

class Settings extends StatelessWidget {
  const Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
          child: SafeArea(
              child: Padding(
                  padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Info(),
                                ));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "INFO",
                                style: TextStyle(
                                    color: Color(0xFFde1f55), fontSize: 25),
                              ),
                            ),
                          )))))),
    );
  }
}
