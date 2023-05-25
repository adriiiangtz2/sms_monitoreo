// To parse this JSON data, do
//
//     final maponUnits = maponUnitsFromJson(jsonString);

import 'dart:convert';

List<MaponUnits> maponUnitsFromJson(String str) => List<MaponUnits>.from(json.decode(str).map((x) => MaponUnits.fromJson(x)));

String maponUnitsToJson(List<MaponUnits> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaponUnits {
    final int boxId;
    final String name;
    final int unitId;
    
    bool? imgLoad;

    MaponUnits({
        required this.boxId,
        required this.name,
        required this.unitId,
         required this. imgLoad,
    });

    factory MaponUnits.fromJson(Map<String, dynamic> json) => MaponUnits(
        boxId: json["box_id"],
        name: json["name"],
        unitId: json["unit_id"], imgLoad: null,
    );

    Map<String, dynamic> toJson() => {
        "box_id": boxId,
        "name": name,
        "unit_id": unitId,
    };
}
