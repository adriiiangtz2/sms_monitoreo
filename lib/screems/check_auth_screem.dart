import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:monitoreo_sms/services/services.dart';
import 'package:provider/provider.dart';
import 'package:monitoreo_sms/screems/screems.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: readToken(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator.adaptive();
              }


              if (snapshot.data == "") {
                Future.microtask(() {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const LoginScreen(),
                          transitionDuration: const Duration(seconds: 0)));
                });
              } else {
                Future.microtask(() {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                           pageBuilder: (_, __, ___) =>  InicioScreen(),
                          // pageBuilder: (_, __, ___) => const HomeScreen3(),
                          transitionDuration: const Duration(seconds: 0)));
                });
              }
              return Container();
            }),
      ),
    );
  }

  Future<String?> readToken(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('idToken') ?? "";
    String baseUrl = 'www.consola-sudsolutions.mx';
    
    if (token == "") {
      
      return "";
    
    } else {
      
      try {
        
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final url = Uri.https(baseUrl, "/sms/comando/get/all");

        await http.get(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': prefs.getString('idToken') ?? "",
          },
        );
        // final respuesta = json.decode(resp.body);
        // print(respuesta);
        // print(respuesta[0]["comando"]);
        // print("correcto");

        return prefs.getString('idToken') ?? "";
      } catch (e) {
        // print("Fallo");

        final auth = Provider.of<AuthService>(context, listen: false);
        await auth.refresToken();

        // print(prefs.getString('idToken') ?? "");

        return prefs.getString('idToken') ?? "";
      }
    }
  }
}
