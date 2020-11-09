import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:wled/settings.dart';
import 'dart:convert';
import 'EffectList.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _brightness = 0;

  bool isOn = false;

  sendData(String args, String value) async {
    return await http.post(
      'http://4.3.2.1/win' + args + "=" + value,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  getData() async {
    final response = await http.get(
      'http://4.3.2.1/json',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (json.decode(response.body)['state']['on'] == true) {
      setState(() {
        isOn = true;
      });
    } else {
      isOn = false;
    }

    //print(json.decode(response.body)['state']['seg']);

    setState(() {
      _currentEffect =
          effects[json.decode(response.body)['state']['seg'][0]['fx']];
      _brightness = json.decode(response.body)['state']['bri'];
    });
  }

  Color _currentColor = Colors.blue;
  String _currentEffect = "";
  Timer timer;
  double _speed = 0;

  void _onColorChanged(Color color) {
    setState(() => _currentColor = color);
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => getData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: Color(0xfff1f3f6),
        child: SafeArea(
          child: Container(
              child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hello Kendal",
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Settings(),
                              ));
                        },
                        child: Icon(
                          Icons.settings,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Controller",
                            style:
                                TextStyle(fontSize: 25, color: Colors.black)))),
                Padding(
                    padding: EdgeInsets.only(top: 145),
                    child: Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),

                              spreadRadius: 5,
                              blurRadius: 60,
                              offset:
                                  Offset(10, 10), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ))),
                Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),

                              spreadRadius: 5,
                              blurRadius: 60,
                              offset:
                                  Offset(10, 10), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ))),
                Padding(
                    padding: EdgeInsets.only(top: 300),
                    child: Text("Dashboard",
                        style: TextStyle(fontSize: 25, color: Colors.black))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 350),
                      child: Container(
                        height: 120,
                        width: 170,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),

                              spreadRadius: 5,
                              blurRadius: 60,
                              offset:
                                  Offset(20, 10), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("FX",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold))),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Choose Effect",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 350),
                      child: Container(
                        height: 120,
                        width: 170,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),

                              spreadRadius: 5,
                              blurRadius: 60,
                              offset:
                                  Offset(20, 10), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Icon(
                                    Icons.palette,
                                    size: 60,
                                  )),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Choose Pallete",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 500),
                      child: Container(
                        height: 120,
                        width: 170,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),

                              spreadRadius: 5,
                              blurRadius: 60,
                              offset:
                                  Offset(20, 10), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Icon(
                                        Icons.palette,
                                        size: 60,
                                      ))),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Information",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 500),
                      child: Container(
                        height: 120,
                        width: 170,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),

                              spreadRadius: 5,
                              blurRadius: 60,
                              offset:
                                  Offset(20, 10), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Icon(
                                    Icons.palette,
                                    size: 60,
                                  )),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Sleep Mode",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
