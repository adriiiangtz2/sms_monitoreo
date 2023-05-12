// To parse this JSON data, do
//
//     final dataUnits = dataUnitsFromJson(jsonString);

import 'dart:convert';

List<DataUnits> dataUnitsFromJson(String str) => List<DataUnits>.from(json.decode(str).map((x) => DataUnits.fromJson(x)));

String dataUnitsToJson(List<DataUnits> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataUnits {
    DataUnits({
        required this.hardware,
        required this.id,
        required this.image,
        required this.name,
        required this.position,
        required this. imgLoad,
    });

    int hardware;
    int id;
    String image;
    String name;
    Position position;
     bool? imgLoad;

    factory DataUnits.fromJson(Map<String, dynamic> json) => DataUnits(
        hardware: json["hardware"],
        id: json["id"],
        image: json["image"],
        name: json["name"],
        position: Position.fromJson(json["position"]), imgLoad: null,
    );

    Map<String, dynamic> toJson() => {
        "hardware": hardware,
        "id": id,
        "image": image,
        "name": name,
        "position": position.toJson(),
    };
}

class Position {
    Position({
        required this.x,
        required this.y,
    });

    double x;
    double y;

    factory Position.fromJson(Map<String, dynamic> json) => Position(
        x: json["x"]?.toDouble(),
        y: json["y"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
    };
}
