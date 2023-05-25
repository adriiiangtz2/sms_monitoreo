// To parse this JSON data, do
//
//     final unitsDetailsMapon = unitsDetailsMaponFromJson(jsonString);

import 'dart:convert';

UnitsDetailsMapon unitsDetailsMaponFromJson(String str) => UnitsDetailsMapon.fromJson(json.decode(str));

String unitsDetailsMaponToJson(UnitsDetailsMapon data) => json.encode(data.toJson());

class UnitsDetailsMapon {
    final int boxId;
    final String imei;
    final bool installed;
    final String model;
    final String modelVer;
    final String phone;
    final String serial;
    final int unitId;

    UnitsDetailsMapon({
        required this.boxId,
        required this.imei,
        required this.installed,
        required this.model,
        required this.modelVer,
        required this.phone,
        required this.serial,
        required this.unitId,
    });

    factory UnitsDetailsMapon.fromJson(Map<String, dynamic> json) => UnitsDetailsMapon(
        boxId: json["box_id"],
        imei: json["imei"],
        installed: json["installed"],
        model: json["model"],
        modelVer: json["model_ver"],
        phone: json["phone"],
        serial: json["serial"],
        unitId: json["unit_id"],
    );

    Map<String, dynamic> toJson() => {
        "box_id": boxId,
        "imei": imei,
        "installed": installed,
        "model": model,
        "model_ver": modelVer,
        "phone": phone,
        "serial": serial,
        "unit_id": unitId,
    };
}
