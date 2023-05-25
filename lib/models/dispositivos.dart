// To parse this JSON data, do
//
//     final devices = devicesFromJson(jsonString);

import 'dart:convert';

List<Devices> devicesFromJson(String str) => List<Devices>.from(json.decode(str).map((x) => Devices.fromJson(x)));

String devicesToJson(List<Devices> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Devices {
    Devices({
        required this.dvComandos,
        required this.dvDispositivo,
        required this.dvHardware,
        required this.dvImage,
        required this.idDispositivo,
        required this.marca,
    });

    List<DvComando> dvComandos;
    String dvDispositivo;
    String dvHardware;
    String dvImage;
    int idDispositivo;
    Marca marca;

    factory Devices.fromJson(Map<String, dynamic> json) => Devices(
        dvComandos: List<DvComando>.from(json["dv_comandos"].map((x) => DvComando.fromJson(x))),
        dvDispositivo: json["dv_dispositivo"],
        dvHardware: json["dv_hardware"],
        dvImage: json["dv_image"],
        idDispositivo: json["id_dispositivo"],
        marca: Marca.fromJson(json["marca"]),
    );

    Map<String, dynamic> toJson() => {
        "dv_comandos": List<dynamic>.from(dvComandos.map((x) => x.toJson())),
        "dv_dispositivo": dvDispositivo,
        "dv_hardware": dvHardware,
        "dv_image": dvImage,
        "id_dispositivo": idDispositivo,
        "marca": marca.toJson(),
    };
}

class DvComando {
    DvComando({
        required this.cdComando,
        required this.idComando,
    });

    String cdComando;
    int idComando;

    factory DvComando.fromJson(Map<String, dynamic> json) => DvComando(
        cdComando: json["cd_comando"],
        idComando: json["id_comando"],
    );

    Map<String, dynamic> toJson() => {
        "cd_comando": cdComando,
        "id_comando": idComando,
    };
}

class Marca {
    Marca({
        required this.idMarca,
        required this.mcImage,
        required this.mcMarca,
    });

    int idMarca;
    String mcImage;
    String mcMarca;

    factory Marca.fromJson(Map<String, dynamic> json) => Marca(
        idMarca: json["id_marca"],
        mcImage: json["mc_image"],
        mcMarca: json["mc_marca"],
    );

    Map<String, dynamic> toJson() => {
        "id_marca": idMarca,
        "mc_image": mcImage,
        "mc_marca": mcMarca,
    };
}
