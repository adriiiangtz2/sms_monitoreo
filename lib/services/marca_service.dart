
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:monitoreo_sms/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MarcaService extends ChangeNotifier {

      // MarcaService({
      //   marcasAll()
      // });

     final String _baseUrl = 'www.consola-sudsolutions.mx';
       var marcaArray = [];
var arregloAux = [];
List<String> unitsArray = [];
  Future marcasAll() async {
    unitsArray = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
        marcaArray = [];
 final url = Uri.https(_baseUrl, "/sms/marca/get/all");

    final resp = await http.get( url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
    );
    
    final marcaList = json.decode(resp.body);

     
    for (var element in marcaList) { 
     String user = jsonEncode(element);
      unitsArray.add(user);
    }

    arregloAux = marcaList;

    // print(arregloAux);

    for (var element in arregloAux) {
      // print(element);
      final tempUnits = MarcaGps.fromMap(element);
      marcaArray.add(tempUnits);
    }

    

    // print(marcaArray);
    
  return marcaArray;




  }


 Future createMarca(String name) async {
    // print("_________Entra______________");
     final SharedPreferences prefs = await SharedPreferences.getInstance();

    // print(token);
    final url = Uri.https(_baseUrl, "/sms/marca/create");

    final resp = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
      body: jsonEncode(<String, String>{
      'mc_image': "",
      'mc_marca': name,
    }),
    );
    await marcasAll();
    print("TODO EXCELENTE");
   
    notifyListeners();
  }

   Future editMarca(String edit , int id ) async {


    print("_________Entra______________");
     final SharedPreferences prefs = await SharedPreferences.getInstance();

    // print(token);
    final url = Uri.https(_baseUrl, "/sms/marca/update/${id}");

    final resp = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
      body: jsonEncode(<String, String>{
      'mc_image': "",
      'mc_marca': edit,
    }),
    );
    await marcasAll();
    print("TODO EXCELENTE");
   
    notifyListeners();
  }
   Future deleteMarca(String edit , int id ) async {


    print("_________Entra______________");
     final SharedPreferences prefs = await SharedPreferences.getInstance();

    // print(token);
    final url = Uri.https(_baseUrl, "/sms/marca/delete/${id}");

    final resp = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
    //   body: jsonEncode(<String, String>{
    //   'mc_image': "",
    //   'mc_marca': edit,
    // }),
    );
    await marcasAll();
    print("TODO EXCELENTE");
   
    notifyListeners();
  }

 




  
  
}