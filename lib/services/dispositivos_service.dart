
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:monitoreo_sms/models/models.dart';
import 'package:monitoreo_sms/provider/provider.dart';
import 'package:monitoreo_sms/services/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DispositivosService extends ChangeNotifier {

    var devicesArray=[];
    final String _baseUrl = 'www.consola-sudsolutions.mx';
    var oneUnit;

    Future dispositivosAll( idMarca) async {
    devicesArray = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
        // marcaArray = [];
 final url = Uri.https(_baseUrl, "/sms/dispositivo/get/marca/${idMarca}");

    final resp = await http.get( url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
    );
    
    final marcaList = json.decode(resp.body);
    // print(marcaList);

    print("--- - -- - -- - ");

    for (var element in marcaList) {
      // print(element);
      final tempUnits = Devices.fromJson(element);
      // print(tempUnits);
      devicesArray.add(tempUnits);
    }

    notifyListeners();

    return devicesArray;
  }
    Future<bool> dispositivosMarcaCheck( idMarca) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = Uri.https(_baseUrl, "/sms/dispositivo/get/marca/${idMarca}");

    final resp = await http.get( url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
    );
    
    final marcaList = json.decode(resp.body);
    return (marcaList.length == 0) ? true : false;
  }

      var deviceValidator =[];
      var deviceTotal =[];
    Future dispositivosTotal() async {
      print("Entro en dispositivosTotal");
    deviceValidator =[];
    deviceTotal =[];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
        // marcaArray = [];
 final url = Uri.https(_baseUrl, "/sms/dispositivo/get/all");

    final resp = await http.get( url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
    );
    
    final marcaList = json.decode(resp.body);
    // print(marcaList);

    // print("--- - -- - -- - ");

    for (var element in marcaList) {
      // print(element);
      final tempUnits = Devices.fromJson(element);
      // print(tempUnits);
      // print(tempUnits.dvHardware);
      deviceValidator.add(tempUnits.dvHardware);
      // devicesArray.add(tempUnits);
      deviceTotal.add(tempUnits);
    }
    // print(deviceValidator);

    //  UnistProvider.getOnetUnit(133);
 
    return marcaList ;
  }
    Future dispositivosTotal2(idMarca , context) async {
      print("Entro en dispositivosTotal");
    deviceValidator =[];
    deviceTotal =[];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
        // marcaArray = [];
 final url = Uri.https(_baseUrl, "/sms/dispositivo/get/all");

    final resp = await http.get( url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
    );
    
    final marcaList = json.decode(resp.body);
    // print(marcaList);

    // print("--- - -- - -- - ");

    for (var element in marcaList) {
      // print(element);
      final tempUnits = Devices.fromJson(element);
      // print(tempUnits);
      // print(tempUnits.dvHardware);
      deviceValidator.add(tempUnits.dvHardware);
      // devicesArray.add(tempUnits);
      deviceTotal.add(tempUnits);
    }

      final units = Provider.of<UnistProvider>(context, listen: false);
      final marcaserive = Provider.of<MarcaService>(context, listen: false);

      await units.getOnetUnit(idMarca);
     await  marcaserive.marcasAll();
          notifyListeners();
  
  





    return marcaList ;
  }
    Future dispositivosTotal2Mapon(idMarca , context) async {
      print("Entro en dispositivosTotal");
    deviceValidator =[];
    deviceTotal =[];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
        // marcaArray = [];
 final url = Uri.https(_baseUrl, "/sms/dispositivo/get/all");

    final resp = await http.get( url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
    );
    
    final marcaList = json.decode(resp.body);
    // print(marcaList);

    // print("--- - -- - -- - ");

    for (var element in marcaList) {
      // print(element);
      final tempUnits = Devices.fromJson(element);
      // print(tempUnits);
      // print(tempUnits.dvHardware);
      deviceValidator.add(tempUnits.dvHardware);
      // devicesArray.add(tempUnits);
      deviceTotal.add(tempUnits);
    }

      final units = Provider.of<UnistProvider>(context, listen: false);
      final marcaserive = Provider.of<MarcaService>(context, listen: false);

      await units.getOnetUnitMapon(idMarca);
     await  marcaserive.marcasAll();
          notifyListeners();
  
  





    return marcaList ;
  }

  

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

















   Future createDevice(String nameDivice , hw , fkMarca ) async {
    // print("_________Entra______________");
     final SharedPreferences prefs = await SharedPreferences.getInstance();

    // print(token);
    final url = Uri.https(_baseUrl, "/sms/dispositivo/create");

    final resp = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
      body: jsonEncode(<String, String>{
      'dv_dispositivo':nameDivice ,
      'dv_hardware': "$hw",
      'dv_image': "",
      'dv_fk_marca': fkMarca,
    }),
    );
    // await marcasAll();
    print("TODO EXCELENTE");
   
    notifyListeners();
  }

  Future editDevice(String editName , int idDevice , int idMarca) async {


    print("_________Entra______________");
     final SharedPreferences prefs = await SharedPreferences.getInstance();

    // print(token);
    final url = Uri.https(_baseUrl, "/sms/dispositivo/update/${idDevice}");

    final resp = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
      body: jsonEncode(<String, String>{
    'dv_dispositivo':editName ,
      // 'dv_hardware': "$hw",
      // 'dv_image': "",
      'dv_fk_marca': idMarca.toString(),
    }),
    );
    await dispositivosAll(idMarca);
    await dispositivosTotal();
    print("TODO EXCELENTE");
   
    notifyListeners();
  }

  Future deleteDevice(int idDevice , int idMarca) async {


    print("_________Entra______________");
     final SharedPreferences prefs = await SharedPreferences.getInstance();

    // print(token);
    final url = Uri.https(_baseUrl, "/sms/dispositivo/delete/${idDevice}");

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
     await dispositivosAll(idMarca);
     await dispositivosTotal();

    print("TODO EXCELENTE");
   
    notifyListeners();
  }




  

  

  



}