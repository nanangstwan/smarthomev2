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
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final dataMode1 = snapshot.data as DatabaseEvent?;
                final modeLamp1 =
                    dataMode1?.snapshot.value?.toString() ?? "ERROR";
                return StreamBuilder(
                  stream: FirebaseDatabase.instance
                      .ref()
                      .child('statusLamp1')
                      .onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final dataStatus1 = snapshot.data as DatabaseEvent?;
                      final statusLamp1 =
                          dataStatus1?.snapshot.value?.toString() ?? "ERROR";

                      final device = DeviceIOT(
                        alias: "",
                        icon: Icons.view_column_sharp,

                        location: "Koridor",
                        mode: modeLamp1 == 'remote'
                            ? IotMode.remote
                            : IotMode.auto,
                        status: statusLamp1 == "1" ? "HIDUP" : "MATI",
                        type: IotType.smartLamp,
                        onSwitch: () {
                          int targetStatus = statusLamp1 == "1" ? 0 : 1;
                          FirebaseDatabase.instance
                              .ref()
                              .update({"statusLamp1": targetStatus});
                        },
                      );

                      return LampCard(
                        isLoading: false,
                        device: device,
                        onModeChannge: (mode) {
                          FirebaseDatabase.instance
                              .ref()
                              .update({"lampMode1": mode});
                        },
                      );
                    }

                    return LampCard(isLoading: true, device: DeviceIOT.empty());
                  },
                );
              }

              return LampCard(isLoading: true, device: DeviceIOT.empty());
            },
          ),
                    StreamBuilder(
            stream: FirebaseDatabase.instance.ref().child('statusAc').onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final dataAc = snapshot.data as DatabaseEvent?;
                final statusAc = dataAc?.snapshot.value?.toString() ?? 'ERROR';
                return StreamBuilder(
                    stream:
                        FirebaseDatabase.instance.ref().child('acTemp').onValue,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final dataAc = snapshot.data as DatabaseEvent?;
                        final acTemp = dataAc?.snapshot.value?.toString();

                        final device = DeviceIOT(
                          alias: '',
                          location: 'AC Ruang Tamu',
                          type: IotType.infrared,
                          icon: Icons.air,
                          status: statusAc == "0" ? 'Off' : acTemp! + "\u00b0C",
                          mode: IotMode.remote,
                          onSwitch: (() {
                            int targetStatus = statusAc == '1' ? 0 : 1;
                            FirebaseDatabase.instance
                                .ref()
                                .update({'statusAc': targetStatus, 'antiLooping': true});
                          }),
                        );
                        return ACCARD(isLoading: false, device: device);
                      }
                      return ACCARD(
                          isLoading: false, device: DeviceIOT.empty());
                    });
              }

              return ACCARD(isLoading: true, device: DeviceIOT.empty());
            },
          ),
        ],
      ),
    );
  }
}
