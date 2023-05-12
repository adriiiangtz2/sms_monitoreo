

import 'package:flutter/material.dart';
import 'package:monitoreo_sms/provider/provider.dart';
import 'package:monitoreo_sms/screems/screems.dart';
import 'package:monitoreo_sms/services/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckLoginScreen extends StatefulWidget {
   
  const CheckLoginScreen({Key? key}) : super(key: key);

  @override
  State<CheckLoginScreen> createState() => _CheckLoginScreenState();
}

class _CheckLoginScreenState extends State<CheckLoginScreen> {

   Future<String?> getValue() async {
   print("ReadToken");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Leyendo token
    // await storage.read(key: 'idToken') ?? '';
    var token = prefs.getString('idToken');
    print(prefs.getString('idToken'));
    print("--");
    if(token == null){
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const LoginScreen()));


  }else{

    // ignore: use_build_context_synchronously
    // final unidadesProvider = Provider.of<UnistProvider>(context);
     // ignore: use_build_context_synchronously
     print("entra ");
     final UnistProvider _picker = UnistProvider();
      await _picker.getUnits();
      print( _picker.getUnits());
    
     Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const HomeScreen()));


  }

   
  }
    
  //  String? token;
@override
  void initState() {
    getValue();


    super.initState();
    // _navigateToHome();
  }

  _navigateToHome() async {

    // Obtain shared preferences.
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//       // final authService = Provider.of<AuthService>(context , listen: false);
      

//   var  action =  prefs.getString('idToken');
//   print("nfffj");

//  print(prefs.getString('idToken'));

//   final String? list = prefs.getString('list');
//   print(list);

//   print(action);
//   ignore: unnecessary_null_comparison
//   if(action == null){
//         // ignore: use_build_context_synchronously
//         Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (BuildContext context) => const LoginScreen()));


//   }else{

//     // final unidadesProvider = Provider.of<UnistProvider>(context);
//      // ignore: use_build_context_synchronously
//       // unidadesProvider.getUnits();
//      Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (BuildContext context) => const HomeScreen()));


//   }
   
  }

  @override
  Widget build(BuildContext context) {

    print("Enteaaaa");

    





   
    return const Scaffold(
      body: Center(
         child: Text('Espere'),
      ),
    );
  }
}