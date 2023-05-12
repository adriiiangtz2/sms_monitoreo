// To parse this JSON data, do
//
//     final pruebaWialon = pruebaWialonFromMap(jsonString);

import 'dart:convert';

class PruebaWialon {
    PruebaWialon({
        required this.nm,
        required this.cls,
        required this.id,
        required this.mu,
        required this.uacl,
    });

    String nm;
    int cls;
    int id;
    int mu;
    int uacl;

    factory PruebaWialon.fromJson(String str) => PruebaWialon.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PruebaWialon.fromMap(Map<String, dynamic> json) => PruebaWialon(
        nm: json["nm:"],
        cls: json["cls"],
        id: json["id"],
        mu: json["mu"],
        uacl: json["uacl"],
    );

    Map<String, dynamic> toMap() => {
        "nm:": nm,
        "cls": cls,
        "id": id,
        "mu": mu,
        "uacl": uacl,
    };
}
