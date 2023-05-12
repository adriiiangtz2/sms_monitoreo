// To parse this JSON data, do
//
//     final unitsDetails = unitsDetailsFromMap(jsonString);

import 'dart:convert';

UnitsDetails unitsDetailsFromMap(String str) => UnitsDetails.fromMap(json.decode(str));

String unitsDetailsToMap(UnitsDetails data) => json.encode(data.toMap());

class UnitsDetails {
    UnitsDetails({
        required this.act,
        required this.cls,
        required this.dactt,
        required this.hw,
        required this.id,
        required this.mu,
        required this.nm,
        required this.ph,
        required this.ph2,
        required this.psw,
        this.retr,
        required this.uacl,
        required this.uid,
        required this.uid2,
        this.vp,
    });

    int act;
    int cls;
    int dactt;
    Hw hw;
    int id;
    int mu;
    String nm;
    String ph;
    String ph2;
    String psw;
    dynamic retr;
    int uacl;
    String uid;
    String uid2;
    dynamic vp;

    factory UnitsDetails.fromMap(Map<String, dynamic> json) => UnitsDetails(
        act: json["act"],
        cls: json["cls"],
        dactt: json["dactt"],
        hw: Hw.fromMap(json["hw"]),
        id: json["id"],
        mu: json["mu"],
        nm: json["nm"],
        ph: json["ph"],
        ph2: json["ph2"],
        psw: json["psw"],
        retr: json["retr"],
        uacl: json["uacl"],
        uid: json["uid"],
        uid2: json["uid2"],
        vp: json["vp"],
    );

    Map<String, dynamic> toMap() => {
        "act": act,
        "cls": cls,
        "dactt": dactt,
        "hw": hw.toMap(),
        "id": id,
        "mu": mu,
        "nm": nm,
        "ph": ph,
        "ph2": ph2,
        "psw": psw,
        "retr": retr,
        "uacl": uacl,
        "uid": uid,
        "uid2": uid2,
        "vp": vp,
    };
}

class Hw {
    Hw({
        required this.hwCategory,
        required this.hwFeatures,
        required this.id,
        required this.name,
        required this.tp,
        required this.uid2,
        required this.up,
    });

    String hwCategory;
    String hwFeatures;
    int id;
    String name;
    String tp;
    int uid2;
    String up;

    factory Hw.fromMap(Map<String, dynamic> json) => Hw(
        hwCategory: json["hw_category"],
        hwFeatures: json["hw_features"],
        id: json["id"],
        name: json["name"],
        tp: json["tp"],
        uid2: json["uid2"],
        up: json["up"],
    );

    Map<String, dynamic> toMap() => {
        "hw_category": hwCategory,
        "hw_features": hwFeatures,
        "id": id,
        "name": name,
        "tp": tp,
        "uid2": uid2,
        "up": up,
    };
}
