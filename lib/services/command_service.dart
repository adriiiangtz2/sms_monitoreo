
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:monitoreo_sms/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class CommandService extends ChangeNotifier {

  var commandArray=[];
     String baseUrl = 'www.consola-sudsolutions.mx';
 List<String> commandsArrayList =[];
Future commandsAll() async {

    commandArray = [];
    commandsArrayList =[];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
        // marcaArray = [];
 final url = Uri.https(baseUrl, "/sms/comando/get/all");

    final resp = await http.get( url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
    );
    
    final commandList = json.decode(resp.body);
    print(commandList);

     for (var element in commandList) { 
     String comand = jsonEncode(element);
      commandsArrayList.add(comand);
    }
    

    // print(commandsArrayList);



    // print("--- - -- - -- - ");

     
    // for (var element in marcaList) { 
    //  String user = jsonEncode(element);
    //   unitsArray.add(user);
    //   print(element);
    // }

    // arregloAux = marcaList;

    // // print(arregloAux);

    for (var element in commandList) {
      // print(element);
      final tempCommand = Command.fromJson(element);
      // print(tempCommand);
      commandArray.add(tempCommand);
    }
    return commandArray;
  }




Future createNameCommand(String name) async {
    // print("_________Entra______________");
     final SharedPreferences prefs = await SharedPreferences.getInstance();

    // print(token);
    final url = Uri.https(baseUrl, "/sms/comando/create");

    final resp = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
      body: jsonEncode(<String, String>{
      'cd_comando': name,
      // 'mc_marca': name,
    }),
    );
    await commandsAll();
    print("TODO EXCELENTE");
   
    notifyListeners();
      }

    Future editNameCommand(String edit , int id ) async {


    print("_________Entra______________");
     final SharedPreferences prefs = await SharedPreferences.getInstance();

    // print(token);
    final url = Uri.https(baseUrl, "/sms/comando/update/${id}");

    final resp = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
      body: jsonEncode(<String, String>{
      // 'mc_image': "",
      'cd_comando': edit,
    }),
    );
    await commandsAll();
    print("TODO EXCELENTE");
   
    notifyListeners();
  }
   Future deleteMarca(String edit , int id ) async {


    print("_________Entra______________");
     final SharedPreferences prefs = await SharedPreferences.getInstance();

    // print(token);
    final url = Uri.https(baseUrl, "/sms/marca/delete/${id}");

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
    // await marcasAll();
    print("TODO EXCELENTE");
   
    notifyListeners();
  }


  
  Future<List> commandSms(lista , idhardware ) async{
     final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(idhardware);
    print("___");
    print(lista);
    print("___");

    var idDispo;
    for (Devices element in lista) {
      final dvh = element.dvHardware;
      // print(element.dvHardware);
      if ('$idhardware'== dvh) {
          print("Entrooo");
        
      idDispo=element.idDispositivo;
      }
      // print(idhardware);
    }
    // print("___id");
    // print(idDispo);
    // print("___id");

    // print(idDispo);
    final url = Uri.https(baseUrl, "/sms/dispositivo_comando/get/dispositivo/all/$idDispo");

    final resp = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
    );

     final comandList = json.decode(resp.body); 
     print(comandList);
     print("----");
    var arraysms=[];

    //  print(comandList);
     for (var element in comandList) {

        final sms = CommandSms.fromJson(element);

        arraysms.add(sms);
       
     }

    //  arraysms  = arraysms;
     return arraysms;



  }

   var arraysmsM=[];
  Future commandSmsMenu(idDevice) async{
    arraysmsM=[];
     final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // print(idDispo);
    final url = Uri.https(baseUrl, "/sms/dispositivo_comando/get/dispositivo/all/$idDevice");

    final resp = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
    );

    
     final comandList = json.decode(resp.body);

    //  print(comandList);
     for (var element in comandList) {

        final sms = CommandSms.fromJson(element);

        arraysmsM.add(sms);
       
     }
     print(arraysmsM);

    //  arraysms  = arraysms;
    //  return arraysms;

     await commandsAll();
     return arraysmsM;



  }
  Future<bool> commandVerificar(idDevice) async{
     final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // print(idDispo);
    final url = Uri.https(baseUrl, "/sms/dispositivo_comando/get/dispositivo/all/$idDevice");

    final resp = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
    );

    
     final comandList = json.decode(resp.body);

     return (comandList.length == 0) ? true: false;

  }

   Future editCommand( int idCommand , String nameComand,int afkCommand , int afkDevice) async {


    print("_________Entra______________");
     final SharedPreferences prefs = await SharedPreferences.getInstance();

    // print(token);
    final url = Uri.https(baseUrl, "/sms/dispositivo_comando/update/${idCommand}");

    final resp = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
      body: jsonEncode(<String, String>{
    'dc_fk_comando':afkCommand.toString() ,
      'dc_fk_dispositivo':afkDevice.toString(),
      // 'dv_hardware': "$hw",
      // 'dv_image': "",
      'dc_comando_dispositivo': nameComand,
    }),
    );
   await commandSmsMenu(afkDevice);
    print("Todo correcto Edit comando");
  
    notifyListeners();
  }
   Future deleteCommand( int idCommand , String nameComand,int afkCommand , int afkDevice) async {


    print("_________Entra______________");
     final SharedPreferences prefs = await SharedPreferences.getInstance();

    // print(token);
    final url = Uri.https(baseUrl, "/sms/dispositivo_comando/delete/${idCommand}");

    final resp = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
    //   body: jsonEncode(<String, String>{
    // 'dc_fk_comando':afkCommand.toString() ,
    //   'dc_fk_dispositivo':afkDevice.toString(),
    //   // 'dv_hardware': "$hw",
    //   // 'dv_image': "",
    //   'dc_comando_dispositivo': nameComand,
    // }),
    );
   await commandSmsMenu(afkDevice);
    print("Todo correcto Delete comando");
  
    notifyListeners();
  }
  

  Future createCommand( nameCommand , idCommand , idDivice ) async {
    // print("_________Entra______________");
     final SharedPreferences prefs = await SharedPreferences.getInstance();

    // print(token);
    final url = Uri.https(baseUrl, "/sms/dispositivo_comando/create");

    final resp = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
      body: jsonEncode(<String, String>{
       'dc_fk_comando':idCommand.toString() ,
      'dc_fk_dispositivo':idDivice.toString(),
      'dc_comando_dispositivo': nameCommand,
    }),
    );
    // await marcasAll();
    print("TODO EXCELENTE");
    await commandSmsMenu(idDivice);
   
    notifyListeners();
  }


   Future deleteNameCommand( int idCommand ) async {


    // print("_________Entra______________");
     final SharedPreferences prefs = await SharedPreferences.getInstance();

    // print(token);
    final url = Uri.https(baseUrl, "/sms/comando/delete/${idCommand}");

    final resp = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': prefs.getString('idToken') ?? '',
      },
    );
  //  await commandSmsMenu(afkDevice);

  await commandsAll();
  //   print("Todo correcto Delete comando");
  
    notifyListeners();
  }









//     var comandoDevices = [];

//     Future comandosDispositvo(int idDevice) async {

//       print("Entro em¿n comandosDispositvo");
//     comandoDevices =[];
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//         // marcaArray = [];
//  final url = Uri.https(baseUrl, "/sms/dispositivo_comando/get/dispositivo/all/$idDevice");

//     final resp = await http.get( url,
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': prefs.getString('idToken') ?? '',
//       },
//     );
    
//     final commandList = json.decode(resp.body);
//     print(commandList);

//     // print("--- - -- - -- - ");

     
//     // for (var element in marcaList) { 
//     //  String user = jsonEncode(element);
//     //   unitsArray.add(user);
//     //   print(element);
//     // }

//     // arregloAux = marcaList;

//     // // print(arregloAux);

//     // for (var element in commandList) {
//     //   // print(element);
//     //   final tempCommand = Command.fromJson(element);
//     //   // print(tempCommand);
//     //   commandArray.add(tempCommand);
//     // }
//   }
    

}