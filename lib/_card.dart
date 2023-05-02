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
          // image: DecorationImage(
          //     image: AssetImage(
          //       widget.icon,
          //     ),
          //     fit: BoxFit.cover),
          color: Colors.white,
          // const Color(0XFF249a77),
          borderRadius: BorderRadius.circular(30),
          // boxShadow: const [
          //   BoxShadow(
          //     color: Colors.black,
          //     blurRadius: 5,
          //     // offset: Offset(1.0, 3.0),
          //   ),
          // ],
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
  final Function(String mode)? onModeChange;
  const LampCard({
    Key? key,
    required this.isLoading,
    required this.device,
    this.onModeChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        child: !isLoading
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
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
                                backgroundColor: Colors.white,
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
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              builder: (context) => ModeModal(
                                  mode: device.mode.name,
                                  onModeChange: onModeChange),
                            );
                          },
                          child: Text(
                            device.mode.name.toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          device.alias,
                          style: TextStyle(
                              color: device.mode == IotMode.remote
                                  ? device.status == 'HIDUP'
                                      ? Colors.red
                                      : Colors.black
                                  : Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          device.location,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const MySeparator(
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            device.status == 'HIDUP' ? 'on' : 'off',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        Switch(
                            value: device.status == 'HIDUP',
                            onChanged: device.mode == IotMode.auto
                                ? null
                                : (value) {
                                    device.onSwitch;
                                  })
                      ],
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}

class ModeModal extends StatefulWidget {
  final String mode;
  final Function(String mode)? onModeChange;

  const ModeModal({
    Key? key,
    required this.mode,
    this.onModeChange,
  }) : super(key: key);

  @override
  State<ModeModal> createState() => _ModeModalState();
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
              'Mode',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            ListTile(
              title: const Text('Remote'),
              trailing: mode == 'remote' ? const Icon(Icons.check) : null,
              onTap: () {
                setState(() {
                  mode = 'remote';
                });
              },
            ),
            ListTile(
              title: const Text('Automatic'),
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
                    onPressed: () {
                      widget.onModeChange?.call(mode);
                      Navigator.of(context).pop();
                    },
                    child: const Text('SAVE'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
