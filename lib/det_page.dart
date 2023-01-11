import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


class DetPage extends StatefulWidget {
  const DetPage({super.key});

  @override
  State<DetPage> createState() => _DetPageState();
}

class _DetPageState extends State<DetPage> {
final databaseRef = FirebaseDatabase.instance.ref().child('statusLamp1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: FirebaseAnimatedList(query: databaseRef, itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){
      var x = snapshot.value??['statusLamp1'];
      print(x);
      return ListTile();
      
    })),);
  }
}