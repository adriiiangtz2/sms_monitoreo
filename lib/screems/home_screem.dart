import 'package:flutter/material.dart';
import 'package:monitoreo_sms/models/unitsNew.dart';
import 'package:monitoreo_sms/services/services.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:monitoreo_sms/models/models.dart';
import 'package:monitoreo_sms/provider/provider.dart';
import 'package:monitoreo_sms/widgets/widgets.dart';



class  HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final authService= Provider.of<AuthService>(context);
     final unidadesProvider = Provider.of<UnistProvider>(context);
    //  List<dynamic> unitss = unidadesProvider.pruebaArreglo;

      // unidadesProvider.preferenceUnits();
      final unidades = unidadesProvider.pruebaarray;
      // print("dddd");
      // print(unidades);

   
    return Scaffold(
      appBar: AppBar(       
        title: const Text('Unidades'),
        backgroundColor: const Color(0xFD3234A2),
        actions: [

          Switch(
      // This bool value toggles the switch.
      value: true,
      activeColor: Color.fromRGBO(255, 255, 255, 1),
      onChanged: (value) {
        
      },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
            //Eliminando Storage
            await authService.logaut();
            // Navigator.pushNamed(context, 'login');
            Navigator.of(context).pushNamed('login');
            
            } 
          ),
        ],
      ),
      drawer: const SideMenu(),
      //Vista
      // body: ContentListView(unitss: unitss, unidadesProvider: unidadesProvider) ,
      body: ContentListView(unidades:unidades) ,
    );
  }
}

class ContentListView extends StatefulWidget {
  const ContentListView({
    Key? key,
    required this.unidades,
    // required this.unitss,
    // required this.unidadesProvider,
  }) : super(key: key);

  final List unidades;
  // final UnistProvider unidadesProvider;

  @override
  State<ContentListView> createState() => _ContentListViewState();
}

class _ContentListViewState extends State<ContentListView> {

  //Arreglo auxiliar
  List unidadesAll=[];

  

  @override
  initState() {
    print("Entra initState");

    
    // print(widget.unidades);
     unidadesAll =   widget.unidades;
    // print(unidadesAll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("Inicio build");
    // print(unidadesAll);
  final units= Provider.of<UnistProvider>(context, listen: false);
  final marcas= Provider.of<MarcaService>(context, listen: false);
  final device= Provider.of<DispositivosService>(context, listen: false);

    //   errorImg(String imagen, Units value) async{ 
    //     if(value.imgLoad == true) return "$imagen";
    //     if(value.imgLoad == false) return "Error";
    //     final response = await http.get(Uri.parse(imagen));
    //     if(response.body == "404 Not Found" || response.body == "" ){
    //      value.imgLoad=false;
    //     return "Error";
    //     }else{
    //     value.imgLoad=true;
    //     return value.image;
    //     }
    //  }

     // ignore: no_leading_underscores_for_local_identifiers
    //  _runFilter(String value){
    //    var pruebaArreglo2=[];
    //   //  print("value: $value");
    //       if(value.isEmpty){
    //         // print("Entra sin valor");
    //         pruebaArreglo2=widget.unidades;
    //          setState(() {
    //         unidadesAll=pruebaArreglo2;
    //         });
    //       }
    //       if(value.isNotEmpty){
    //         unidadesAll = widget.unidades;
    //         // print("Entra con valor");
    //          for (var i = 0; i < unidadesAll.length; i++) {
    //           final uni = Units.fromMap(unidadesAll[i]);
    //            final name =  uni.name.toLowerCase();
    //           final input = value.toLowerCase();
    //           if(name.contains(input)){
    //             pruebaArreglo2.add(unidadesAll[i]);
    //             // print(uni.name);
    //           };
    //       } 
    //        setState(() {
    //         unidadesAll=pruebaArreglo2;
    //       });
    //       // print(pruebaArreglo2.length);
    //       }
    //  }




      //  return Column(
      // children: <Widget>[
      //   Container(
      //     margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      //    child:  TextField(
      //     decoration: InputDecoration(
      //       prefixIcon: const Icon(Icons.search),
      //      filled: true,
      //       fillColor: Colors.grey.shade300,
      //       labelText: 'Buscar unidad,Modelo por id o nombre',
      //     ),
      //     // onChanged: (value) => _runFilter(value),
      //    ),
      //   )
      //     ],


          
      //   );
       errorImg(String imagen, DataUnits value) async{ 
        if(value.imgLoad == true) return "$imagen";
        if(value.imgLoad == false) return "Error";
        final response = await http.get(Uri.parse(imagen));
        if(response.body == "404 Not Found" || response.body == "" ){
         value.imgLoad=false;
        return "Error";
        }else{
        value.imgLoad=true;
        return value.image;
        }
     }

       _runFilter(String value){
       var pruebaArreglo2=[];
      //  print("value: $value");
          if(value.isEmpty){
            // print("Entra sin valor");
            pruebaArreglo2=widget.unidades;
             setState(() {
            unidadesAll=pruebaArreglo2;
            });
          }
          if(value.isNotEmpty){
            unidadesAll = widget.unidades;
            // print("Entra con valor");
             for (var i = 0; i < unidadesAll.length; i++) {
              final DataUnits uni = unidadesAll[i];
               final name =  uni.name.toLowerCase();
              final input = value.toLowerCase();
              if(name.contains(input)){
                pruebaArreglo2.add(uni);
                // print(uni.name);
              };
          } 
           setState(() {
            unidadesAll=pruebaArreglo2;
          });
          // print(pruebaArreglo2.length);
          }
     }


    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
         child:  TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
           filled: true,
            fillColor: Colors.grey.shade300,
            labelText: 'Buscar unidad,Modelo por id o nombre',
          ),
          onChanged: (value) => _runFilter(value),
         ),
        ),
        Expanded(     
          child:ListView.builder(
            padding: const EdgeInsets.only(left: 10,right: 10, bottom: 70,top: 10),
            itemCount: unidadesAll.length,
            itemBuilder:(context, index) {
              final DataUnits value =  unidadesAll[index];

                // print(value.hardware);
          
                return Card(
              elevation: 3,
              child: ListTile(

                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  // child: unidad['uri'] == null || unidad['uri'] == ""  ? 
                  child: FutureBuilder(
                    future:errorImg("${unidadesAll[index].image}" ,value ),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return const CircularProgressIndicator();
                        // return  Text("");
                      }
                      // print(snapshot.data);
                      if(snapshot.data == "Error"){
                      return Container(
                        height: 30,
                        width: 30,
                        child: const Icon(Icons.image_not_supported_rounded , color: Color.fromARGB(136, 214, 214, 214),size: 30,));
                    // fit: BoxFit.scaleDown,
                    // width:50,
                    // height: 50,
                    //   );;

                      }else{
                         return Image.network("${snapshot.data}",
                    fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,
                      );
                      }
                  },)
                ),

                onTap: () async {
                  // final authService = Provider.of<AuthService>(context, listen: false);
                 
                  //  final device= Provider.of<DispositivosService>(context, listen: false);
                  //  print("click ${unidadesAll[index].id}");
                  await units.getOnetUnit(unidadesAll[index].id);
                 
                  
                  // await device.dispositivosAll(idMarca);
                

                  // ignore: use_build_context_synchronously
                  // Navigator.pushNamed(context, 'datails', arguments: unidadesAll[index].id);
                  Navigator.of(context).pushNamed('datails' , arguments:unidadesAll[index].id );
                 },
                  title: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(unidadesAll[index].name ,style: const TextStyle( fontWeight: FontWeight.w400,fontSize:13 )),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
              Text("${unidadesAll[index].id}",style: const TextStyle(color: Color(0xFD3234A2), fontWeight: FontWeight.w500,fontSize:13 )),
              Text("Hardware: ${unidadesAll[index].hardware}")
              ],
                ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                       Icon(Icons.copy),
                    ],
                  ),
              ),
                );
              // return  ListTile(
              //   title: Text(unidadesAll[index].name),
              //   leading:Icon(Icons.ac_unit),
              //   subtitle: Padding(
              //   padding: EdgeInsets.only(left: 8),  
              //   child: Row(
              //     children: [
              //       Text('${unidadesAll[index].id}'),
                  
              //       Text(""),
              //     ],
              //   ),            

              //   ),


              // );
              // final unidad = widget.unidades;
              // final Units unitss2 = unidadesAll[index];  
            //   return Card(
            //   elevation: 3,
            //   child: ListTile(
            //     leading: ClipRRect(
            //       borderRadius: BorderRadius.circular(5),
            //       // child: unidad['uri'] == null || unidad['uri'] == ""  ? 
            //       // child: FutureBuilder(
            //       //   future:errorImg(unitss2.image ,unitss2 ),
            //       //   builder: (context, snapshot) {
            //       //     if(!snapshot.hasData){
            //       //       return const CircularProgressIndicator();
            //       //     }
            //       //     // print(snapshot.data);
            //       //     if(snapshot.data == "Error"){
            //       //     return Container(
            //       //       height: 50,
            //       //       width: 50,
            //       //       child: const Icon(Icons.image_not_supported_rounded , color: Color.fromARGB(136, 214, 214, 214),size: 30,));
            //       //   // fit: BoxFit.scaleDown,
            //       //   // width:50,
            //       //   // height: 50,
            //       //   //   );;

            //       //     }else{
            //       //        return Image.network("${snapshot.data}",
            //       //   fit: BoxFit.scaleDown,
            //       //   width: 50,
            //       //   height: 50,
            //       //     );
            //       //     }
            //       // },)
            //     ),

            //     onTap: () async {
            //       final authService = Provider.of<AuthService>(context, listen: false);
            //        final units= Provider.of<UnistProvider>(context, listen: false);
            //       await units.getOnetUnit(authService.token);
            //       // ignore: use_build_context_synchronously
            //       Navigator.pushNamed(context, 'datails', arguments: unidad);
            //      },
            //       title: Padding(
            //         padding: const EdgeInsets.all(2.0),
            //         child: Text(unitss2.name ,style: const TextStyle( fontWeight: FontWeight.w400,fontSize:13 )),
            //       ),
            //       subtitle: Padding(
            //         padding: const EdgeInsets.all(2.0),
            //         child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children:  [
            //   Text("${unitss2.id}",style: const TextStyle(color: Color(0xFD3234A2), fontWeight: FontWeight.w500,fontSize:13 )),
            //   Text("Hardware: ${unitss2.hardware}")
            //   ],
            //     ),
            //       ),
            //       trailing: Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: const [
            //            Icon(Icons.copy),
            //         ],
            //       ),
            //   ),
            //     );
            }, 
            ) 
        )
      ],
    );
  }
}
