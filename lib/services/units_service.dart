import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:monitoreo_sms/models/mapo_units.dart';
import 'package:monitoreo_sms/models/unitsNew.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnitsService extends ChangeNotifier {

  static Future getAllUnits() async {
    var pruebaarray = [];
    
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('items') == null) {
      return;
    } else {
      final List<String> items = prefs.getStringList('items')!;

      for (var element in items) {
        final user = jsonDecode(element);
        pruebaarray.add(DataUnits.fromJson(user));
      }

      return pruebaarray;
    }
  }
  static Future getAllUnitsMapon() async {
    var pruebaarrayMapon = [];
    
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('itemsMapon') == null) {
      return;
    } else {
      final List<String> itemsMapon = prefs.getStringList('itemsMapon')!;

      for (var element in itemsMapon) {
        final user = jsonDecode(element);
        pruebaarrayMapon.add(MaponUnits.fromJson(user));
      }

      return pruebaarrayMapon;
    }
  }



}
