import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:monitoreo_sms/services/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/unitsNew.dart';

class HomeScreen2 extends StatefulWidget {
   
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {


  var  datas = [];


    // Future tomar_datos() async{

    //     final SharedPreferences prefs = await SharedPreferences.getInstance();

    //    final List<String> items =  prefs.getStringList('items')!;

    //   // print(items[0]);
    //     // var stringList = items.join("");
    //     // var i = jsonDecode(items);
    //     var prubaarray=[];
    //     items.forEach((element) { 
    //          var user = jsonDecode(element);
            
    //           // print(DataUnits.fromJson(user));
    //           prubaarray.add(DataUnits.fromJson(user));

    //         //  print(user);

    //         //  var d = DataUnits.fromJson(user);

    //     });

    //     return prubaarray;


   
    //     // // print(jsonDecode(items));
    //     // for (var i = 0; i < items.length; i++) {
          
    //     // }
    //     // for (var element in items) {
    //     //     Map valueMap = json.decode(element);
    //     //   // print(user);
          
    //     // }

        

    // //  print(user);
    //   // prefs.setString('userData', user);

    //   // var registro = [];
    //   // for (data in data) {
    //   //     registro.add(DataUnits.fromJson(data));
    //   // }

    //   // await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);


    //   // print(registro);
    // //  return registro;

    // }

    @override
  void initState() {


    // tomar_datos().then((value) {
    //   setState(() {
    //     // print(value);
    //   datas.add(value);
    //   });
      

    // });

  

  
    super.initState();
  }



 


  @override
  Widget build(BuildContext context) {

     final authService= Provider.of<AuthService>(context,listen: false);
    return  Scaffold(
      appBar: AppBar(       
        title: const Text('Unidades'),
        backgroundColor: const Color(0xFD3234A2),
        actions: [

          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
            //Eliminando Storage
            authService.logaut();
            Navigator.pushReplacementNamed(context, 'checkAuth');
            } 
          ),
        ],
      ),

      body: Padding(padding: const EdgeInsets.all(10.0),
      child: Column(
        children:  [
          const SizedBox(height: 20,),
          const TextField(
            decoration: InputDecoration(
              labelText: "Buscador",suffixIcon: Icon(Icons.search)
            ),
          ),
          const SizedBox(height: 20,),

          Expanded(
            
              child:ListView.builder(
                itemCount: datas[0].length,
                itemBuilder:(context, index) {
                  print(datas);
                  print(index);
               
                  return Container(
                    padding: EdgeInsets.all(30),
                    child: Text(datas[0][index].name),
                  );

                  
                }, 
                
                )
          )

        ],
      )
      
      
      
      
      ),
      
    );
  }
}