import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smarthome_app/screen/device_widget.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _timeString = '';
  String _datestring = '';

  @override
  void initState() {
    _timeString = _formatTime(DateTime.now());
    _datestring = _formatDate(DateTime.now());

    Timer.periodic(
      Duration(seconds: 1),
      (Timer t) => _getTime(),
    );
    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formatedTime = _formatTime(now);
    final String formatedDate = _formatDate(now);
    setState(
      () {
        _timeString = formatedTime;
        _datestring = formatedDate;
      },
    );
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('EEEE, d MMMM yyyy').format(dateTime);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 50, top: 100, right: 50),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'WELCOME BACK,',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const Text(
                      'NANANG SETIAWAN',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'FredokaOne',
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      _datestring,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 70,
                ),
                Column(children: [
                  Text(
                    _timeString,
                    style: const TextStyle(fontSize: 30),
                  ),
                ]),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            width: 470,
            height: 106,
            decoration: BoxDecoration(
              color: Color(0XFF249a77),
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(color: Colors.grey, spreadRadius: 5, blurRadius: 5),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // const Padding(
                //   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                // ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/picture/icons8-temperature-high-32.png',
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'TEMPERATURE',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                            Text(
                              '24°',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/picture/icons8-humidity-64.png',
                        height: 30,
                        width: 30,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'HUMIDITY',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                            Text(
                              '70%',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          DeviceWidget()
        ],
      ),
    );
  }
}
