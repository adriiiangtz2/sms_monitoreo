// To parse this JSON data, do
//
//     final authToken = authTokenFromMap(jsonString);

import 'dart:convert';

class AuthToken {
    AuthToken({
        required this.authToken,
        required this.isAuth,
        required this.plataforms,
        required this.userData,
        required this.wtoken,
    });

    String authToken;
    bool isAuth;
    List<Plataform> plataforms;
    UserData userData;
    String wtoken;

    factory AuthToken.fromJson(String str) => AuthToken.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AuthToken.fromMap(Map<String, dynamic> json) => AuthToken(
        authToken: json["auth_token"],
        isAuth: json["is_auth"],
        plataforms: List<Plataform>.from(json["plataforms"].map((x) => Plataform.fromMap(x))),
        userData: UserData.fromMap(json["user_data"]),
        wtoken: json["wtoken"],
    );

    Map<String, dynamic> toMap() => {
        "auth_token": authToken,
        "is_auth": isAuth,
        "plataforms": List<dynamic>.from(plataforms.map((x) => x.toMap())),
        "user_data": userData.toMap(),
        "wtoken": wtoken,
    };
}

class Plataform {
    Plataform({
        required this.idPlataform,
        required this.pfColor,
        required this.pfData,
        required this.pfName,
        required this.pfToken,
    });

    int idPlataform;
    String pfColor;
    PfData pfData;
    String pfName;
    String pfToken;

    factory Plataform.fromJson(String str) => Plataform.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Plataform.fromMap(Map<String, dynamic> json) => Plataform(
        idPlataform: json["id_plataform"],
        pfColor: json["pf_color"],
        pfData: PfData.fromMap(json["pf_data"]),
        pfName: json["pf_name"],
        pfToken: json["pf_token"],
    );

    Map<String, dynamic> toMap() => {
        "id_plataform": idPlataform,
        "pf_color": pfColor,
        "pf_data": pfData.toMap(),
        "pf_name": pfName,
        "pf_token": pfToken,
    };
}

class PfData {
    PfData({
        this.appKey,
        this.appSecret,
        this.userId,
        this.userPwd,
    });

    String? appKey;
    String? appSecret;
    String? userId;
    String? userPwd;

    factory PfData.fromJson(String str) => PfData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PfData.fromMap(Map<String, dynamic> json) => PfData(
        appKey: json["app_key"],
        appSecret: json["app_secret"],
        userId: json["user_id"],
        userPwd: json["user_pwd"],
    );

    Map<String, dynamic> toMap() => {
        "app_key": appKey,
        "app_secret": appSecret,
        "user_id": userId,
        "user_pwd": userPwd,
    };
}

class UserData {
    UserData({
        required this.idUser,
        required this.lastLogin,
        required this.usName,
        required this.userType,
    });

    int idUser;
    String lastLogin;
    String usName;
    UserType userType;

    factory UserData.fromJson(String str) => UserData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        idUser: json["id_user"],
        lastLogin: json["last_login"],
        usName: json["us_name"],
        userType: UserType.fromMap(json["user_type"]),
    );

    Map<String, dynamic> toMap() => {
        "id_user": idUser,
        "last_login": lastLogin,
        "us_name": usName,
        "user_type": userType.toMap(),
    };
}

class UserType {
    UserType({
        required this.id,
        required this.type,
    });

    int id;
    String type;

    factory UserType.fromJson(String str) => UserType.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserType.fromMap(Map<String, dynamic> json) => UserType(
        id: json["id"],
        type: json["type"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
    };
}
