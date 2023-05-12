import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:monitoreo_sms/models/unitsNew.dart';
import 'package:monitoreo_sms/services/services.dart';
import 'package:monitoreo_sms/ui/ui.dart';
import 'package:provider/provider.dart';
import 'package:monitoreo_sms/models/models.dart';
import 'package:monitoreo_sms/provider/provider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:background_sms/background_sms.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:toast/toast.dart';
// import 'package:flutter_sms/flutter_sms.dart';

class DatailsScreen extends StatefulWidget {
  const DatailsScreen({Key? key}) : super(key: key);

  @override
  State<DatailsScreen> createState() => _DatailsScreenState();
}

class _DatailsScreenState extends State<DatailsScreen> {

  final myController = TextEditingController();
    
    @override
    void initState() {
    super.initState();

    // myController.addListener(_printLatestValue(""));
  }

   @override
  void dispose() {
    // Limpia el controlador cuando el widget se elimine del árbol de widgets
    // Esto también elimina el listener _printLatestValue
    myController.dispose();
    super.dispose();
  }

   _printLatestValue(String codigo) {
    myController.text = "${codigo}";
  }
   _clearInput() {
    myController.text = "";
  }

   Future<bool> _isPermissionGranted() async =>
      await Permission.sms.status.isGranted;

    _getPermission() async => await [
        Permission.sms,
      ].request();
      

    

  @override
  Widget build(BuildContext context) {
    //  ToastContext().init(context);
    
    final routName = ModalRoute.of(context)!.settings.arguments;
    print(routName);

    final oneUnit = Provider.of<UnistProvider>(context);
    final deviceSer = Provider.of<DispositivosService>(context);
    final comand = Provider.of<CommandService>(context);
    final UnitsDetails unidadid = oneUnit.oneUnit;
    // print(unidadid);
    final hwIsRegister = deviceSer.deviceValidator.contains(unidadid.hw.id);
    // print("Hadware");
    // print(hwIsRegister);

    String comandoEscrito ="";

    void displayAddDispositivo(BuildContext context) {
      // print(listMarca);;
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 5,
              title: const Text('Agregar Dispositivo',
                  textAlign: TextAlign.center),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(20)),
              content: SizedBox(
                width: 600,
                // height: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ChangeNotifierProvider(
                      create: (context) => FormProvider(),
                      child: _formAddDispositivo(),
                    )
                  ],
                ),
              ),
              actions: const [
                // TextButton(
                //     onPressed: () => Navigator.pop(context),
                //     child: const Center(child: Text('vuelva a intentarlo'))),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text("Comandos e informacion"),
          backgroundColor: const Color(0xFD3234A2),
          actions: [
            IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  //Eliminando Storage
                  // Navigator.pushNamed(context, 'login');
                  Navigator.of(context).pushNamed('selects');
                })
          ]),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 5,),
              ExpansionTile(
                title: Text(
                  'Nombre Unidad : ${unidadid.nm}',
                  style: const TextStyle(
                      // color: Color(0xFD3234A2),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                subtitle: const Text('Informacion de la unidad',
                    style: TextStyle(color: Color(0xFD3234A2))),
              
                children: <Widget>[
                  Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.person_pin_circle_outlined,
                                  size: 60, color: Color(0xFD3234A2)),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text('Nombre:'),
                                  Text('Telefono:'),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text('Sin nombre api',
                                      style: TextStyle(
                                          color: Color(0xFD3234A2),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                  Text('sin telefono ',
                                      style: TextStyle(
                                          color: Color(0xFD3234A2),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              Divider(height: 1, color: Colors.grey.shade400),
              const SizedBox(height: 5,),
              ExpansionTile(
                title: const Text('Hardware',
                    style: TextStyle(
                        color: Color(0xFD3234A2),
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                subtitle: const Text('Informacion de Hadware',style: TextStyle(color: Color(0xFD3234A2))),
                children: <Widget>[
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: Column(
                        children: [
                         
                        
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.gps_fixed,
                                    size: 60, color: Color(0xFD3234A2)),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Text('Marca:', style:TextStyle(fontSize: 16),),
                                    Text('Dispositivo:', style:TextStyle(fontSize: 16),),
                                    Text('Telefono:', style:TextStyle(fontSize: 16),),
                                    Text('ID:', style:TextStyle(fontSize: 16),),
                                    Text('Hardware:', style:TextStyle(fontSize: 16),),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children:  [
                                    Text(unidadid.hw.name,
                                        style: const TextStyle(
                                            color: Color(0xFD3234A2),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                    Text(unidadid.hw.name,
                                        style: const TextStyle(
                                            color: Color(0xFD3234A2),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                    Text(unidadid.ph,
                                        style: const TextStyle(
                                            color: Color(0xFD3234A2),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                    Text(unidadid.uid,
                                        style: const TextStyle(
                                            color: Color(0xFD3234A2),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                    Text('${unidadid.hw.id}',
                                        style: const TextStyle(
                                            color: Color(0xFD3234A2),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: 1, color: Colors.grey.shade400),
              const SizedBox(
                height: 10,
              ),
              if (hwIsRegister) ...{
                Card(
                  elevation: 4,
                  color: Colors.grey.shade100,
                  child: Container(
                    width: double.infinity,
                    // height: 500,
                    // color: Color.fromARGB(255, 206, 206, 206),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),


                          child: TextField(
                              controller: myController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.message),
           filled: true,
            fillColor: Colors.grey.shade300,
            labelText: myController.text,
          ),
          // onChanged: (value) => _runFilter(value),
         ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          disabledColor: Colors.grey,
                          elevation: 0,
                          color: Color(0xFD3234A2),
                          // ignore: sort_child_properties_last
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 125, vertical: 15),
                            child: Text('Enviar', style: TextStyle(color: Colors.white)),
                          ),
                          onPressed: () async {
                          final telefono = unidadid.ph;
                          
                          print("ENVIARRRR COMANDO : ${myController.text}");

                                         SmsStatus result = await BackgroundSms.sendMessage(
                                phoneNumber: "${telefono}",
                                
                                message: "${myController.text}",
                                simSlot: 1);
                            if (result == SmsStatus.sent) {
                              print("Enviado");

                            //  Toast.show("Mensaje enviado", duration: Toast.lengthShort, gravity:  Toast.bottom);
                            } else {
                              print("error");
                              // showToast("Mensaja no enviado", gravity: Toast.bottom );
                            }


                          _clearInput();




                          


                          },
                        ),
                        SizedBox( height: 400,

                          child: FutureBuilder(
                          future:comand.commandSms(deviceSer.deviceTotal ,unidadid.hw.id )  ,
                          builder: (context, AsyncSnapshot<List<dynamic>>  snapshot) {
                              // print(snapshot.data?.length);
                            if(snapshot.hasData){
                            final  data = snapshot.data;

                            print(data);
                        
                              return Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                     crossAxisCount: 2,
                                     crossAxisSpacing: 3.0,
                                     mainAxisSpacing: 3.0,
                                   ),
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) {
                                    print(data?[index]);

                                    final CommandSms dta = data?[index];
                                   


                                           return Card(
                                            child: ListTile(
                                              minVerticalPadding: 60,
                                              title: Text("${dta.comando.cdComando}"),
                                              onTap: () async {

                                                   if (await _isPermissionGranted()) {
                                                   String  newstring = '${dta.dcComandoDispositivo}';
                                                  final resp=   newstring.replaceAll('{ID}', "${unidadid.uid}").replaceAll("{id}", "${unidadid.uid}");
                                                  print(resp);
                                                 _printLatestValue(resp);
                                                 }else {
                                                   print("No entro");
                                                    _getPermission();

                                                 }
                                              

                                                 
 
   
  


                                               
                                               
                                              },
                                            ),
                                           );
                                    
                                  },),
                              );
                              
                            }else{
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                        
                          },
                           
                        
                        
                          
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              } else
                DottedBorder(
                  dashPattern: [10, 10],
                  strokeWidth: 1,
                  padding: EdgeInsets.symmetric(horizontal: 100 , vertical: 200),
                  borderPadding: EdgeInsets.all(4),


                  child: Column(
                    children: [
                      Icon(Icons.arrow_downward_sharp,
                      size: 20,
                      ),
                      MaterialButton(
                        minWidth: 100,
                        height: 35,
                        onPressed: () {
                          // print("Modal");
                          displayAddDispositivo(context);
                        },
                        color: const Color(0xFD3234A2),
                        child: const Text('Registrar Dispositivo',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //    void showToast(String msg, {int? duration, int? gravity}) {
  //   Toast.show(msg, duration: duration, gravity: gravity);
  // }

}

class _formAddDispositivo extends StatelessWidget {
  //   final MarcaGps data;
  //  _formAddDispositivo({
  //   // required this.data

  //  });

  // MarcaGps marca;

  StepperType stepperType = StepperType.horizontal;

  @override
  Widget build(BuildContext context) {
    // print(data.mcMarca);
    // print(wi)

    // print(marca);
    final registerForm = Provider.of<FormProvider>(context);
    final marcaserive = Provider.of<MarcaService>(context);
    final val = jsonDecode(marcaserive.unitsArray.first);
    final unidades = marcaserive.unitsArray;

    var init = "${val['mc_marca']}";

    return Form(
      key: registerForm.formKeyMarca,
      child: Column(
        children: [
          _dropButon(unidades: unidades),
        ],
      ),
    );
  }
}

class _dropButon extends StatefulWidget {
  _dropButon({
    super.key,
    required this.unidades,
  });

  final List<String> unidades;

  @override
  State<_dropButon> createState() => _dropButonState();
}

class _dropButonState extends State<_dropButon> {
  var array = [];

  String selectval2 = "United States of America";

  @override
  void initState() {
    // print( widget.unidades);
    for (var element in widget.unidades) {
      final aux = jsonDecode(element);
      array.add(aux);
    }
    selectval2 = "${array[0]["id_marca"]}";

    super.initState();
  }

  List<String> listitems = [
    "United States of America",
    "Canada",
    "United Kingdom",
    "China",
    "Russia",
    "Austria"
  ];
  String selectval = "United States of America";

  @override
  Widget build(BuildContext context) {
    // print(array);
    // print(selectval2);

    final registerForm = Provider.of<FormProvider>(context);
    final disposi = Provider.of<DispositivosService>(context);
    final marcaserive = Provider.of<MarcaService>(context);
    final unidadesProvider = Provider.of<UnistProvider>(context);
    final UnitsDetails unidadid = unidadesProvider.oneUnit;
     final device= Provider.of<DispositivosService>(context, listen: false);
      final marca= Provider.of<MarcaService>(context, listen: false);
    // print("------ Vista --------- ");
    // print(unidadid.hw.id);

    return Container(
      child: Column(
        children: [
          const Text("Escoja una Marca"),
          DropdownButton<dynamic>(
            value: selectval2,
            onChanged: (value) {
              // print(value);

              setState(() {
                selectval2 = value.toString();
              });
            },
            items: array.map((itemone) {
              // print(itemone);

              return DropdownMenuItem(
                value: "${itemone["id_marca"]}",
                child: Text("${itemone["mc_marca"]}"),
              );
            }).toList(),
          ),
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade300,
              // labelText: 'Editar Marca',
              hintText: "Escribe el modelo del GPS",
            ),
            // initialValue: data.mcMarca,

            onChanged: (value) => registerForm.dispositivo = value,
            validator: (value) =>
                (value == "") ? "Ingrese un modelo de GPS" : null,
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: const Color(0xFD3234A2),
            // ignore: sort_child_properties_last
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  registerForm.isLoading ? 'Agregando' : 'Agregar',
                  style: const TextStyle(color: Colors.white),
                )),
            //para bloquear el boton poner null
            onPressed: registerForm.isLoading
                ? null
                : () async {
                    //ocultar telcado al dar press
                    FocusScope.of(context).unfocus();
                    //valiar y cambiar boton
                    if (!registerForm.isValidFormMarca()) return;
                    //bloquear
                    registerForm.isLoading = true;

                    print("Nombre del dispo; ${registerForm.dispositivo}");
                    print("id de marca: ${selectval2}");
                    print("Hardware unidad : ${unidadid.hw.id}");
                    // print(data.idMarca);
                    // await marcaserive.deleteMarca(registerForm.marca, data.idMarca);
                    


                    await disposi.createDevice("${registerForm.dispositivo}", unidadid.hw.id, selectval2);
                    await device.dispositivosTotal();
                   
                    await  marca.marcasAll();
                    registerForm.isLoading = false;
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('marcas');
                    //desbloquear
                  },
          )
        ],
      ),
    );
  }
}
