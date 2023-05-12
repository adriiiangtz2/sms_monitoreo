// To parse this JSON data, do
//
//     final command = commandFromJson(jsonString);

import 'dart:convert';

Command commandFromJson(String str) => Command.fromJson(json.decode(str));

String commandToJson(Command data) => json.encode(data.toJson());

class Command {
    Command({
        required this.cdComando,
        required this.idComando,
    });

    String cdComando;
    int idComando;

    factory Command.fromJson(Map<String, dynamic> json) => Command(
        cdComando: json["cd_comando"],
        idComando: json["id_comando"],
    );

    Map<String, dynamic> toJson() => {
        "cd_comando": cdComando,
        "id_comando": idComando,
    };
}
