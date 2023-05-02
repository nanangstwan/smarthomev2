import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smarthome_app/_card.dart';
import 'package:smarthome_app/data/dummy_data.dart';  

class DeviceWidget extends StatefulWidget {
  const DeviceWidget({super.key});

  @override
  State<DeviceWidget> createState() => _DeviceWidgetState();
}

class _DeviceWidgetState extends State<DeviceWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        // shrinkWrap: true,
        crossAxisCount: 2,
        children: [
          StreamBuilder(
            stream: FirebaseDatabase.instance.ref().child('lampMode1').onValue,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                final dataMode1 = snapshot.data as DatabaseEvent?;
                final modeLamp1 =
                    dataMode1?.snapshot.value?.toString() ?? 'ERROR';
                return StreamBuilder(
                  stream: FirebaseDatabase.instance
                      .ref()
                      .child('statusLamp1')
                      .onValue,
                  builder: ((context, snapshot) {
                    final dataStatus1 = snapshot.data as DatabaseEvent?;
                    final statusLamp1 =
                        dataStatus1?.snapshot.value.toString() ?? 'ERROR';
                    final device = DeviceIOT(
                      alias: 'alias',
                      location: 'location',
                      type: IotType.smartLamp,
                      icon: Icons.laptop_mac,
                      status: statusLamp1 == '1' ? 'HIDUP' : 'MATI',
                      mode:
                          modeLamp1 == 'remote' ? IotMode.remote : IotMode.auto,
                      onSwitch: (() {
                        int targetStatus = statusLamp1 == '1' ? 0 : 1;
                        FirebaseDatabase.instance
                            .ref()
                            .update({'statusLamp1': targetStatus});
                      }),
                    );
                    return LampCard(isLoading: false, device: device);
                  }),
                );
              }
              return LampCard(isLoading: true, device: DeviceIOT.empty());
            }),
          ),
        ],
      ),
    );
  }
}
