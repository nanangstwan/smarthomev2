import 'package:flutter/material.dart';            
import 'dart:async';

import 'package:smarthome_app/screen/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return Home();
        }),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF763626),
      body: Center(
        child: Container(
          child: const Text(
            'SMARTHOME',
            style: TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // child: Image.asset(
        //   'picture/logo.png',
        //   width: 200.0,
        //   height: 100.0,
        // ),
      ),
    );
  }
}
