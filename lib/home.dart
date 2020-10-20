import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wled/settings.dart';
import 'flutter_circle_color_picker.dart';
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
      'http://lights.local/win' + args + "=" + value,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  getData() async {
    final response = await http.get(
      'http://lights.local/json',
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
        child: SafeArea(
          child: Container(
            child: Stack(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 120),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: CircleColorPicker(
                          initialColor: _currentColor,
                          onChanged: _onColorChanged,
                          strokeWidth: 10,
                          colorCodeBuilder: (context, color) {
                            return Text(
                              color
                                  .toString()
                                  .replaceAll('Color(0xff', '')
                                  .replaceAll(')', '')
                                  .toUpperCase(),
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: _currentColor,
                              ),
                            );
                          },
                        ))),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Hello Kendal",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
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
                        ))),
                Padding(
                    padding: EdgeInsets.only(top: 47),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                Text(
                                  isOn ? "Connected" : "Not Connected",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.fiber_manual_record,
                                  color: Colors.white,
                                  size: 8,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '$_currentEffect',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )))),

                /*Padding(
                        padding: EdgeInsets.all(20),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => sendData("FX", "0"),
                                child: Container(
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Color(0xfff1f3f6),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                      child: Text(
                                    "Solid",
                                    style: TextStyle(fontSize: 25),
                                  )),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () => sendData("FX", "1"),
                                child: Container(
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Color(0xfff1f3f6),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                      child: Text(
                                    "Android",
                                    style: TextStyle(fontSize: 25),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        )),*/
                Padding(
                    padding: EdgeInsets.only(top: 430, left: 30, right: 30),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: GestureDetector(
                            onTap: () => (getData()),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  "EFFECTS",
                                  style: TextStyle(
                                      color: Color(0xFFde1f55), fontSize: 25),
                                ),
                              ),
                            )))),
                Padding(
                    padding: EdgeInsets.only(top: 600),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text("BRIGHTNESS",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                        (_brightness / 255 * 100)
                                                .round()
                                                .toString() +
                                            "%",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                  )),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                  Container(
                                      width: 320,
                                      child: Slider(
                                          activeColor: Color(0xFFde1f55),
                                          inactiveColor: Colors.white,
                                          min: 0,
                                          max: 255,
                                          value: _brightness,
                                          onChanged: (value) => setState(() {
                                                _brightness = value;
                                              }),
                                          onChangeEnd: (double newValue) {
                                            sendData(
                                                "&A", _brightness.toString());
                                          })),
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 700),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text("EFFECT SPEED",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                        (_speed / 255 * 100)
                                                .round()
                                                .toString() +
                                            "%",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                  )),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                  Container(
                                      width: 320,
                                      child: Slider(
                                          activeColor: Color(0xFFde1f55),
                                          inactiveColor: Colors.white,
                                          min: 0,
                                          max: 255,
                                          value: _speed,
                                          onChanged: (value) => setState(() {
                                                _speed = value;
                                              }),
                                          onChangeEnd: (double newValue) {
                                            sendData("&SX", _speed.toString());
                                          })),
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
