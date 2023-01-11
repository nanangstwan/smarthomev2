import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final DBref = FirebaseDatabase.instance.ref();
  int ledStatus = 0;
  String lampMode = '';
  bool isLoading = false;
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  getLEDStatus() async {
    await DBref.child('statusLamp1').once().then((DatabaseEvent databaseEvent) {
      print('ledStatus' + databaseEvent.snapshot.value.toString());
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    isLoading = true;
    getLEDStatus();
    super.initState();
    DBref;
    getLEDStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: (() {
                    statusPresed();
                  }),
                  child: Text(ledStatus == 0 ? 'on' : 'off'),
                ),
          const SizedBox(width: 50),
          // StreamBuilder(
              // stream: DBref.child('statusLamp1').onValue,
              // builder: (context, snapshot) {
              //   if (snapshot.hasData) {
              //     DatabaseEvent? data = snapshot.data as DatabaseEvent?;
              //     print(data?.snapshot.value);
              //   }
              //   const SizedBox(width: 20);
              //   return const Text('Data Tidak ditemukan');
              // }
            // ),
        ]),
      ),
    );
  }

  void statusPresed() {
    ledStatus == 0
        ? DBref.child('statusLamp1').set(1)
        : DBref.child('statusLamp1').set(0);
    if (ledStatus == 0) {
      setState(() {
        ledStatus = 1;
      });
    } else {
      setState(() {
        ledStatus = 0;
      });
    }
  }
}
