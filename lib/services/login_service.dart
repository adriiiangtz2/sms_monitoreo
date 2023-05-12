import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class AuthService extends ChangeNotifier {
  var tokenArray = [];
  bool inicioSesion = false;
  late String token;
  final String _baseUrl = 'www.consola-sudsolutions.mx';
  var pruebaarray = [];

  Future authLogin(String name, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> authData = {
      'us_name': name,
      'password': password,
    };
    final url = Uri.https(_baseUrl, "/login");
    final resp = await http.post(
      url,
      body: json.encode(authData),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    // print(decodeResp['plataforms'][0]['pf_name']);
    if (decodeResp["is_auth"] == false) {
      // inicioSesion = false;
      notifyListeners();
    } else {
      token = decodeResp["auth_token"];

      // print(decodeResp['user_data']['us_name']);
      // Guardando en el storage
      await prefs.setString('idToken', decodeResp["auth_token"]);
      await prefs.setString('us_name', decodeResp['user_data']['us_name']);
      await prefs.setString('nameLogin',name);
      await prefs.setString('passLogin',password);

      final url = Uri.https(_baseUrl, "/units");

      final resp = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': prefs.getString('idToken') ?? '',
        },
      );
      var data = json.decode(resp.body);
      //  print(data[0]);
      List<String> unitsArray = [];
      for (var element in data) {
        String user = jsonEncode(element);
        unitsArray.add(user);
      }
      await prefs.setStringList('items', unitsArray);

      inicioSesion = true;
      notifyListeners();
    }
  }

  Future logaut() async {
    //Eliminando del storage
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('idToken');
    await prefs.remove('arrayUnits');
    await prefs.remove('items');
    await prefs.remove('us_name');
    await prefs.clear();
    notifyListeners();
    return;
  }

  Future<String?> readToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Leyendo toke
    // notifyListeners();
    return prefs.getString('idToken') ?? "";
  }

  Future refresToken() async{
      // final String _baseUrl = 'www.consola-sudsolutions.mx';

      final SharedPreferences prefs = await SharedPreferences.getInstance();
    final  name =  prefs.getStringList('nameLogin');
    final  password =  prefs.getStringList('passLogin');

      final Map<String, dynamic> authData = {
      'us_name': name,
      'password': password,
    };
    final url = Uri.https(_baseUrl, "/login");
    final resp = await http.post(
      url,
      body: json.encode(authData),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final Map<String, dynamic> decodeResp = json.decode(resp.body);

      token = decodeResp["auth_token"];
      await prefs.remove('idToken');
      await prefs.setString('idToken', decodeResp["auth_token"]);
      notifyListeners();


  }

  Future refreshList() async{
     final SharedPreferences prefs = await SharedPreferences.getInstance();


final url = Uri.https(_baseUrl, "/units");

      final resp = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': prefs.getString('idToken') ?? '',
        },
      );
      var data = json.decode(resp.body);
      //  print(data[0]);
      List<String> unitsArray = [];
      for (var element in data) {
        String user = jsonEncode(element);
        unitsArray.add(user);
      }
      await prefs.setStringList('items', unitsArray);
      print("YES");

       notifyListeners();


}
}

