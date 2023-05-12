import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:monitoreo_sms/models/unitsNew.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UnitsService extends ChangeNotifier {
  static Future getAllUnits() async {
    var pruebaarray = [];
    final String _baseUrl = 'www.consola-sudsolutions.mx';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //  final url = Uri.https(_baseUrl, "/units");

    //   final resp = await http.get(
    //     url,
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //       'Authorization': prefs.getString('idToken') ?? '',
    //     },
    //   );
    //   var data = json.decode(resp.body);
    //   //  print(data[0]);
    //   List<String> unitsArray = [];
    //   for (var element in data) {
    //     String user = jsonEncode(element);
    //     unitsArray.add(user);
    //   }

    //   pruebaarray =[];
    if (prefs.getStringList('items') == null) {
      return;
    } else {
      final List<String> items = prefs.getStringList('items')!;

      for (var element in items) {
        var user = jsonDecode(element);
        // print(DataUnits.fromJson(user));
        pruebaarray.add(DataUnits.fromJson(user));
      }

      return pruebaarray;
    }
  }
}
