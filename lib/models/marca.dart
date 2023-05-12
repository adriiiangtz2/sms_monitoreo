// To parse this JSON data, do
//
//     final marcaGps = marcaGpsFromMap(jsonString);

import 'dart:convert';

List<MarcaGps> marcaGpsFromMap(String str) => List<MarcaGps>.from(json.decode(str).map((x) => MarcaGps.fromMap(x)));

String marcaGpsToMap(List<MarcaGps> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class MarcaGps {
    MarcaGps({
        required this.idMarca,
        required this.mcImage,
        required this.mcMarca,
    });

    int idMarca;
    String mcImage;
    String mcMarca;

    factory MarcaGps.fromMap(Map<String, dynamic> json) => MarcaGps(
        idMarca: json["id_marca"],
        mcImage: json["mc_image"],
        mcMarca: json["mc_marca"],
    );

    Map<String, dynamic> toMap() => {
        "id_marca": idMarca,
        "mc_image": mcImage,
        "mc_marca": mcMarca,
    };
}
