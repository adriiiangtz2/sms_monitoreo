// To parse this JSON data, do
//
//     final commandSms = commandSmsFromJson(jsonString);

import 'dart:convert';

CommandSms commandSmsFromJson(String str) => CommandSms.fromJson(json.decode(str));

String commandSmsToJson(CommandSms data) => json.encode(data.toJson());

class CommandSms {
    CommandSms({
        required this.comando,
        required this.dcComandoDispositivo,
        required this.dispositivo,
        required this.idDispositivoComando,
    });

    Comando comando;
    String dcComandoDispositivo;
    Dispositivo dispositivo;
    int idDispositivoComando;

    factory CommandSms.fromJson(Map<String, dynamic> json) => CommandSms(
        comando: Comando.fromJson(json["comando"]),
        dcComandoDispositivo: json["dc_comando_dispositivo"],
        dispositivo: Dispositivo.fromJson(json["dispositivo"]),
        idDispositivoComando: json["id_dispositivo_comando"],
    );

    Map<String, dynamic> toJson() => {
        "comando": comando.toJson(),
        "dc_comando_dispositivo": dcComandoDispositivo,
        "dispositivo": dispositivo.toJson(),
        "id_dispositivo_comando": idDispositivoComando,
    };
}

class Comando {
    Comando({
        required this.cdComando,
        required this.idComando,
    });

    String cdComando;
    int idComando;

    factory Comando.fromJson(Map<String, dynamic> json) => Comando(
        cdComando: json["cd_comando"],
        idComando: json["id_comando"],
    );

    Map<String, dynamic> toJson() => {
        "cd_comando": cdComando,
        "id_comando": idComando,
    };
}

class Dispositivo {
    Dispositivo({
        required this.dvComandos,
        required this.dvDispositivo,
        required this.dvHardware,
        required this.dvImage,
        required this.idDispositivo,
        required this.marca,
    });

    List<Comando> dvComandos;
    String dvDispositivo;
    int dvHardware;
    String dvImage;
    int idDispositivo;
    Marcas marca;

    factory Dispositivo.fromJson(Map<String, dynamic> json) => Dispositivo(
        dvComandos: List<Comando>.from(json["dv_comandos"].map((x) => Comando.fromJson(x))),
        dvDispositivo: json["dv_dispositivo"],
        dvHardware: json["dv_hardware"],
        dvImage: json["dv_image"],
        idDispositivo: json["id_dispositivo"],
        marca: Marcas.fromJson(json["marca"]),
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

class Marcas {
    Marcas({
        required this.idMarca,
        required this.mcImage,
        required this.mcMarca,
    });

    int idMarca;
    String mcImage;
    String mcMarca;

    factory Marcas.fromJson(Map<String, dynamic> json) => Marcas(
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
