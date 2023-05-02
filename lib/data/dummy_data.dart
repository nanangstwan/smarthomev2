import 'package:flutter/material.dart';

class DeviceIOT {
    String alias;
    String location;
    IconData icon;
    String status;
    IotMode mode;
    IotType type;

    void Function() onSwitch;

    DeviceIOT({
        required this.alias,
        required this.location,
        required this.type,
        required this.icon,
        required this.status,
        required this.mode,
        required this.onSwitch,
    });

    factory DeviceIOT.empty(){
        return DeviceIOT(
            alias : '',
            icon : Icons.abc,
            location : '',
            mode : IotMode.remote,
            onSwitch : (){},
            status : '',
            type : IotType.smartLamp,
        );
    }
}

enum IotMode {
    remote,
    auto
}

enum IotType {
    smartLamp,
    infrared
}