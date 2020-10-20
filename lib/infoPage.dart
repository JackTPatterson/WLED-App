import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  String version = "0";
  int vid = 0;
  int ledCount = 0;
  String name = "Loading";
  double power;
  double maxPower;
  String arch = "Loading";
  String core = "Loading";
  String mac = "Loading";
  int heap = 0;
  int rssi = 0;
  int signal = 0;
  String bssid = "Loading";
  int fxCount = 0;
  int palCount = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final response = await http.get(
      'http://lights.local/json',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    //print(json.decode(response.body)['state']['seg']);

    print(json.decode(response.body)['info']);

    setState(() {
      version = json.decode(response.body)['info']['ver'];
      vid = json.decode(response.body)['info']['vid'];
      ledCount = json.decode(response.body)['info']['leds']['count'];
      name = json.decode(response.body)['info']['name'];
      arch = json.decode(response.body)['info']['arch'];
      core = json.decode(response.body)['info']['core'];
      heap = json.decode(response.body)['info']['freeheap'];
      rssi = json.decode(response.body)['info']['wifi']['rssi'];
      mac = json.decode(response.body)['info']['mac'];
      signal = json.decode(response.body)['info']['wifi']['signal'];
      bssid = json.decode(response.body)['info']['wifi']['bssid'];
      fxCount = json.decode(response.body)['info']['fxcount'];
      palCount = json.decode(response.body)['info']['palcount'];
      //power = json.decode(response.body)['info']['leds']['pwr'];
      //maxPower = json.decode(response.body)['info']['leds']['maxpwr'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                    ),
                    child: Text(
                      "Info",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Version:',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          '$version',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Build:',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          '$vid',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'LED Count:',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          '$ledCount',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Name:',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          '$name',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Architecture:',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          '$arch',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Core:',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          '$core',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Heap:',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          '$heap',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'RSSI:',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          '$rssi',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'MAC Address:',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          '$mac',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Signal',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          '$signal',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'FX Count',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          '$fxCount',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pallete Count',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          '$palCount',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
