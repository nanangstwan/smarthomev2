import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smarthome/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MaterialColor MyColor = MaterialColor(0xFF763626, <int, Color>{
    50: Color(0xFF763626),
    100: Color(0xFF763626),
    200: Color(0xFF763626),
    400: Color(0xFF763626),
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light, 
      // primarySwatch: MyColor
      ),
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}
