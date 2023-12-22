import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smarthome_app/data/dummy_data.dart';
import 'package:smarthome_app/screen/myseparator.dart';

class MyCard extends StatefulWidget {
  final String icon;
  final String nama;
  final VoidCallback onclick;

  const MyCard(
      {Key? key, required this.icon, required this.nama, required this.onclick})
      : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onclick,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(25),
        decoration: BoxDecoration(

          color: Colors.white,
          // const Color(0XFF249a77),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // const Padding(
            //   padding: EdgeInsets.all(10),
            // ),
            Image.asset(
              widget.icon,
              color: Colors.black,
              height: 50,
              width: 50,
            ),
            const SizedBox(height: 10),
            Text(
              widget.nama,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.black),
            ),
            const MySeparator(
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class LampCard extends StatelessWidget {
  final DeviceIOT device;
  final bool isLoading;
  final Function(String mode)? onModeChannge;
  const LampCard({
    Key? key,
    required this.isLoading,
    required this.device,
    this.onModeChannge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: device.status == "HIDUP" ? Colors.black45 : Colors.white30,
      child: !isLoading
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircleAvatar(
                              backgroundColor: Colors.amber,
                              radius: 30,
                              child: Icon(
                                device.icon,
                                color: device.mode == IotMode.remote
                                    ? Colors.black
                                    : Colors.grey,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            clipBehavior: Clip.hardEdge,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                            builder: (context) => ModeModal(
                              mode: device.mode.name,
                              onModeChannge: onModeChannge,
                            ),
                          );
                        },
                        child: Text(
                          device.mode.name.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        device.alias,
                        style: TextStyle(
                          color: device.mode == IotMode.remote
                              ? device.status == "HIDUP"
                                  ? Colors.white
                                  : Colors.black
                              : Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        device.location,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const MySeparator(color: Colors.amber),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          device.status == "HIDUP" ? 'On' : 'Off',
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Switch(
                        activeColor: Colors.amber,
                        value: device.status != "HIDUP",
                        onChanged: device.mode == IotMode.auto
                            ? null
                            : (value) {
                                device.onSwitch();
                              },
                      )
                    ],
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class ACCARD extends StatelessWidget {
  final DeviceIOT device;
  final bool isLoading;
  final Function(String mode)? onModeChannge;
  const ACCARD({
    Key? key,
    required this.isLoading,
    required this.device,
    this.onModeChannge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: device.status == "Off" ? Colors.white30 : Colors.black45,
      child: !isLoading
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircleAvatar(
                              backgroundColor: Colors.amber,
                              radius: 30,
                              child: Icon(
                                device.icon,
                                color: device.mode == IotMode.remote
                                    ? Colors.black
                                    : Colors.grey,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Switch(
                        value: device.status != 'Off',
                        onChanged: device.mode == IotMode.auto
                            ? null
                            : (v) {
                                device.onSwitch();
                              },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        device.alias,
                        style: TextStyle(
                          color: device.mode == IotMode.remote
                              ? device.status == ""
                                  ? Colors.white
                                  : Colors.black
                              : Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        device.location,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const MySeparator(color: Colors.amber),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              device.status,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Temperature',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StreamBuilder(
                                    stream: FirebaseDatabase.instance
                                        .ref()
                                        .child('acTemp')
                                        .onValue,
                                    builder: (context, snapshot) {
                                      print(snapshot);
                                      if (snapshot.hasData) {
                                        final dataAc =
                                            snapshot.data as DatabaseEvent?;
                                        final acTemp =
                                            dataAc?.snapshot.value?.toString();
                                        return InkWell(
                                          onTap: () {
                                            int saksae =
                                                int.parse(acTemp ?? "0");
                                            // String targetStatus = acTemp == 'false' ? 'true' : 'false';
                                            FirebaseDatabase.instance
                                                .ref()
                                                .update({
                                              "acTemp": saksae - 1,
                                              'acTempStatus': true,
                                              'antiLooping': true
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 70,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: const Text(
                                              '-',
                                              style: TextStyle(
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        );
                                      }
                                      return const CircularProgressIndicator();
                                    }),
                                const SizedBox(width: 10),
                                StreamBuilder(
                                    stream: FirebaseDatabase.instance
                                        .ref()
                                        .child('acTemp')
                                        .onValue,
                                    builder: (context, snapshot) {
                                      print(snapshot);
                                      if (snapshot.hasData) {
                                        final dataAc =
                                            snapshot.data as DatabaseEvent?;
                                        final acTemp =
                                            dataAc?.snapshot.value?.toString();
                                        return InkWell(
                                          onTap: () {
                                            int saksae =
                                                int.parse(acTemp ?? "0");
                                            FirebaseDatabase.instance
                                                .ref()
                                                .update({
                                              "acTemp": saksae + 1,
                                              'acTempStatus': true,
                                              'antiLooping': true
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 70,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: const Text(
                                              '+',
                                              style: TextStyle(
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        );
                                      }
                                      return const CircularProgressIndicator();
                                    }),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class ModeModal extends StatefulWidget {
  final String mode;
  final Function(String mode)? onModeChannge;
  const ModeModal({
    Key? key,
    required this.mode,
    this.onModeChannge,
  }) : super(key: key);

  @override
  _ModeModalState createState() => _ModeModalState();
}

class _ModeModalState extends State<ModeModal> {
  String mode = '';
  @override
  void initState() {
    super.initState();
    mode = widget.mode;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            const Text(
              "Mode",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            ListTile(
              title: const Text("Remote", style: TextStyle(color: Colors.white),),
              trailing: mode == 'remote' ? const Icon(Icons.check) : null,
              onTap: () {
                setState(() {
                  mode = 'remote';
                });
              },
            ),
            ListTile(
              title: const Text("Automatic", style: TextStyle(color: Colors.white),),
              trailing: mode == 'auto' ? const Icon(Icons.check) : null,
              onTap: () {
                setState(() {
                  mode = 'auto';
                });
              },
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      child: const Text('SAVE'),
                      onPressed: () {
                        widget.onModeChannge?.call(mode);
                        Navigator.of(context).pop();
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
