// To parse this JSON data, do
//
//     final units = unitsFromMap(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;

Units unitsFromMap(String str) => Units.fromMap(json.decode(str));

String unitsToMap(Units data) => json.encode(data.toMap());

class Units {
  
    Units({
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


  get fullUnistImg async {

    //     Future errorImg(String imagen) async{

    final response = await http.get(Uri.parse(image));
    // // print(response.body);
    if(response.body == "404 Not Found" || response.body == "" ){

      return "Error";

      }else{

      return "${image}";
      }


    }
    
      
    

    factory Units.fromMap(Map<String, dynamic> json) => Units(
        hardware: json["hardware"],
        id: json["id"],
        image: json["image"],
        name: json["name"],
        position: Position.fromMap(json["position"]), imgLoad: null,
    );

    Map<String, dynamic> toMap() => {
        "hardware": hardware,
        "id": id,
        "image": image,
        "name": name,
        "position": position.toMap(),
    };
}

class Position {
    Position({
        required this.x,
        required this.y,
    });

    double x;
    double y;

    factory Position.fromMap(Map<String, dynamic> json) => Position(
        x: json["x"]?.toDouble(),
        y: json["y"]?.toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "x": x,
        "y": y,
    };
}
