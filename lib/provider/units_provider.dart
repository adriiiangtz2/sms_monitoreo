import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:monitoreo_sms/models/models.dart';
import 'package:monitoreo_sms/models/unitsNew.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnistProvider extends ChangeNotifier {

  var arreglo = [];
  var pruebaArreglo = [];
  final String _baseUrl = 'www.consola-sudsolutions.mx';
   var pruebaarray =[];

  Future getUnits() async {
    pruebaarray =[];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> items =  prefs.getStringList('items')!;

    for (var element in items) { 
        var user = jsonDecode(element);       
        // print(DataUnits.fromJson(user));
        pruebaarray.add(DataUnits.fromJson(user));
        }
    notifyListeners();
    }

  // ignore: prefer_typing_uninitialized_variables
  var oneUnit;

  Future getOnetUnit(int id) async {
    oneUnit = "";
    // oneUnit="";
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     final url = Uri.https(_baseUrl, "/units/$id/hardware/uid");

    final resp = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',}
    );
    final decodeResp = json.decode(resp.body);
    final resps = UnitsDetails.fromMap(decodeResp);
    oneUnit = resps;
    notifyListeners();
  }

    var arregloGeneralUnidades = [];
   Future getValidDispositivo() async {
    }
}

