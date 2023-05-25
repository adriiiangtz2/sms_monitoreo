import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:monitoreo_sms/models/models.dart';
import 'package:monitoreo_sms/provider/provider.dart';
import 'package:monitoreo_sms/services/services.dart';
import 'package:monitoreo_sms/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

class CommandScreen extends StatelessWidget {
   
  const CommandScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
       final comandoss = Provider.of<CommandService>(context , listen: false);

    var idDevice = ModalRoute.of(context)?.settings.arguments;
      // print(idDevice.toString());

      // final  idDispositivo = idDevice[0];



  void createComandDisplay(BuildContext context, idDevice  ) {
    print("Paso createComandDisplay ");
    // print(idDevice);
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 5,
              title: const Text('Nuevo comando', textAlign: TextAlign.center),
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
                      child: _formAddCommand(idDispooo:idDevice),
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
        title: const Text("Comandos"),
        backgroundColor: AppTheme.primary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createComandDisplay(context ,idDevice );
        },
        // backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),

       body: ChangeNotifierProvider(create:(context) => DispositivosService(),
      child: FutureBuilder(
        future: comandoss.commandSmsMenu(idDevice),
        builder:(context, snapshot) {

          if (snapshot.hasData) {

            return _listViewCommand();
            
          }else{

            return const skeletonLoadingCommands();

          }
          
        }, ),


      //  _listViewCommand()
      ),
    );
  }
}

class _listViewCommand extends StatelessWidget {


void displayEditarComando(BuildContext context , comand) {
  // print(device);;
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 5,
              title: const Text('Editar Dispositivo', textAlign: TextAlign.center),
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
                      child: _formCommandEdit(comand:comand),
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

void displayEliminarComando(BuildContext context ,comand) {
  // print(listMarca);;
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 5,
              title: const Text('Eliminar Dispositivo', textAlign: TextAlign.center),
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
                      child: _formDeviceDelete(comand:comand),
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

  @override
  Widget build(BuildContext context) {
     final comandosService = Provider.of<CommandService>(context);

     
    return ListView.builder(
      padding: const EdgeInsets.only(left: 5, right: 10, bottom: 70, top: 5),
      itemCount: comandosService.arraysmsM.length,
      itemBuilder:(context, index) {
        // print("buil");

        // final Devices oneDevice =  device[index];
        final CommandSms  comand = comandosService.arraysmsM[index];
        // print(comand.cdComando);
      
      

        return Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("${comand.comando.cdComando}", style: const TextStyle(fontSize: 20)),
              Expanded(
                  child: Container(
                height: 10,
              )),
              Column(
                children: [
                  MaterialButton(
                    minWidth: 100,
                    height: 35,
                    onPressed: () {
      
                      displayEditarComando(context , comand);
                    },
                    color: AppTheme.primary,
                    child: const Text('EDITAR',
                        style: TextStyle(color: Colors.white)),
                  ),
                  MaterialButton(
                    minWidth: 100,
                    height: 35,
                    onPressed: () {
      
                      displayEliminarComando(context , comand);
      
                    },
                    color: const Color.fromARGB(255, 149, 8, 8),
                    child: const Text('ELIMINAR',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        );
        
      },
      
      );
  }
}

// ignore: camel_case_types, must_be_immutable
class _formAddCommand extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  
   _formAddCommand({
    super.key,
    required this.idDispooo,
  });
  final String idDispooo;
  


  StepperType stepperType = StepperType.horizontal;

  @override
  Widget build(BuildContext context) {

    print(idDispooo);
    
    print("Entro en form");

      final registerForm = Provider.of<FormProvider>(context);

        final comandosService = Provider.of<CommandService>(context);
        final val = jsonDecode(comandosService.commandsArrayList.first);
        print(val);
        final commndos= comandosService.commandsArrayList;

        var init = "${val['cd_comando']}";
        // print(idDevice);



     return Form(
      key: registerForm.formKeyMarca,
      child: Column(
        children: [
          _dropButon(command: commndos  , idDispoo:idDispooo ),
        ],
      ),
    );
  }
}

class _dropButon extends StatefulWidget {
  _dropButon({
    super.key,
    required this.command,
    required this.idDispoo,
  });

  final List<String> command;
  final String idDispoo;
  // var idDevice;

  @override
  State<_dropButon> createState() => _dropButonState();
}
class _dropButonState extends State<_dropButon> {
  var array = [];

  String selectval2 = "United States of America";
  String? idDispositivo;

  @override
  void initState() {
    // print( widget.unidades);
    for (var element in widget.command) {
      final aux = jsonDecode(element);
      array.add(aux);
    }
    selectval2 = "${array[0]["id_comando"]}";
    idDispositivo= widget.idDispoo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(array);
    // print(selectval2);

    final registerForm = Provider.of<FormProvider>(context);
     final comandosService = Provider.of<CommandService>(context);
    // final disposi = Provider.of<DispositivosService>(context);
    // final marcaserive = Provider.of<MarcaService>(context);
    // final unidadesProvider = Provider.of<UnistProvider>(context);
    // final UnitsDetails unidadid = unidadesProvider.oneUnit;
    //  final device= Provider.of<DispositivosService>(context, listen: false);
    // print("------ Vista --------- ");
    // print(unidadid.hw.id);

    return Container(
      child: Column(
        children: [
          const Text("Escoja un nombre de comando"),
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
                value: "${itemone["id_comando"]}",
                child: Text("${itemone["cd_comando"]}"),
              );
            }).toList(),
          ),
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade300,
              // labelText: 'Editar Marca',
              hintText: "Escribe El nombre del comando",
            ),
            // initialValue: data.mcMarca,

            onChanged: (value) => registerForm.command = value,
            validator: (value) =>
                (value == "") ? "escriba el comando" : null,
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


                    // print(idDevice);
                    print("Nombre del comando; ${registerForm.command}");
                    print("id de tipo comando: ${selectval2}");
                    print("id del dispositivo: ${idDispositivo}");

                    // print("Hardware unidad : ${unidadid.hw.id}");
                    // print(data.idMarca);
                    await comandosService.createCommand(registerForm.command , selectval2 , idDispositivo);
                    


                    // await disposi.createDevice("${registerForm.dispositivo}", unidadid.hw.id, selectval2);
                    // await device.dispositivosTotal();
                    registerForm.isLoading = false;
                    Navigator.pop(context);
                    // Navigator.of(context).pushNamed('marcas');
                    //desbloquear
                  },
          )
        ],
      ),
    );
  }
}



class _formCommandEdit extends StatelessWidget {
    final CommandSms comand;
   _formCommandEdit({
    required this.comand

   });

  // MarcaGps marca;


  @override
  Widget build(BuildContext context) {
    // print(comand.dvDispositivo);
      // print(wi)

    // print(marca);
     final registerForm = Provider.of<FormProvider>(context);
    final comandosService = Provider.of<CommandService>(context);
    // final deviceSerive = Provider.of<DispositivosService>(context);
    return Form(
      key: registerForm.formKeyMarca,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade300,
              // labelText: 'Editar Marca',
              // hintText:"${data.mcMarca}",

            ),
            initialValue: comand.dcComandoDispositivo,
            
            onChanged: (value) => registerForm.command = value,
            validator: (value) => ( (value == "")||(registerForm.command =="") ) ? "Favor editar" : null,
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
                  registerForm.isLoading ? 'Editando' : 'Editar',
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
                    
                    print("id comando : ${comand.idDispositivoComando}");
                    print("name nuevo: ${registerForm.command}");
                    print("fk comando: ${comand.comando.idComando}");
                    print("dispositivo: ${comand.dispositivo.idDispositivo}");
                    await comandosService.editCommand(comand.idDispositivoComando,registerForm.command, comand.comando.idComando, comand.dispositivo.idDispositivo);

                    registerForm.isLoading = false;
                    registerForm.command="";
                    Navigator.pop(context);
                    //desbloquear
                  },
          )
        ],
      ),
    );
  }
}

class _formDeviceDelete extends StatelessWidget {
    final CommandSms comand;
   _formDeviceDelete({
    required this.comand

   });

  // MarcaGps marca;



  @override
  Widget build(BuildContext context) {
    // print(data.mcMarca);
      // print(wi)

    // print(marca);
     final registerForm = Provider.of<FormProvider>(context);
    final comandosService = Provider.of<CommandService>(context);
    return Form(
      key: registerForm.formKeyMarca,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade300,
              // labelText: 'Editar Marca',
              hintText:"Escribe \"ELIMINAR\"",

            ),
            // initialValue: data.mcMarca,
            
            onChanged: (value) => registerForm.command = value.trim().replaceAll("\\s{2,}", " "),
            validator: (value) => (registerForm.command == "ELIMINAR") ? null:"Ingrese ELIMINAR" ,
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
                  registerForm.isLoading ? 'Eliminando' : 'Eliminar',
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

                    print("id comando : ${comand.idDispositivoComando}");
                    print("name nuevo: ${registerForm.command}");
                    print("fk comando: ${comand.comando.idComando}");
                    print("dispositivo: ${comand.dispositivo.idDispositivo}");
                     await comandosService.deleteCommand(comand.idDispositivoComando,registerForm.command, comand.comando.idComando, comand.dispositivo.idDispositivo);


                    registerForm.isLoading = false;
                    Navigator.pop(context);
                    //desbloquear
                  },
          )
        ],
      ),
    );
  }
}


class skeletonLoadingCommands extends StatelessWidget {
  const skeletonLoadingCommands({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      // width: 300,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

        
           SizedBox(height: 20),
             SkeletonParagraph(
            style: SkeletonParagraphStyle(
                lines: 2,
                spacing: 6,
                lineStyle: SkeletonLineStyle(
                  randomLength: true,
                  height: 10,
                  borderRadius: BorderRadius.circular(8),
                  minLength: MediaQuery.of(context).size.width / 2,
                ))),
            SizedBox(height: 20),
          
           SizedBox(height: 20),
          SkeletonParagraph(
            style: SkeletonParagraphStyle(
                lines: 2,
                spacing: 6,
                lineStyle: SkeletonLineStyle(
                  randomLength: true,
                  height: 10,
                  borderRadius: BorderRadius.circular(8),
                  minLength: MediaQuery.of(context).size.width / 2,
                ))),
            SizedBox(height: 20),
          
           SizedBox(height: 20),
              SkeletonParagraph(
            style: SkeletonParagraphStyle(
                lines: 2,
                spacing: 6,
                lineStyle: SkeletonLineStyle(
                  randomLength: true,
                  height: 10,
                  borderRadius: BorderRadius.circular(8),
                  minLength: MediaQuery.of(context).size.width / 2,
                ))),
            SizedBox(height: 20),
          
           SizedBox(height: 20),
         SkeletonParagraph(
            style: SkeletonParagraphStyle(
                lines: 2,
                spacing: 6,
                lineStyle: SkeletonLineStyle(
                  randomLength: true,
                  height: 10,
                  borderRadius: BorderRadius.circular(8),
                  minLength: MediaQuery.of(context).size.width / 2,
                ))),
            SizedBox(height: 20),
          
           SizedBox(height: 20),
           SkeletonParagraph(
            style: SkeletonParagraphStyle(
                lines: 2,
                spacing: 6,
                lineStyle: SkeletonLineStyle(
                  randomLength: true,
                  height: 10,
                  borderRadius: BorderRadius.circular(8),
                  minLength: MediaQuery.of(context).size.width / 2,
                ))),
            SizedBox(height: 20),
          
           SizedBox(height: 20),
            SkeletonParagraph(
            style: SkeletonParagraphStyle(
                lines: 2,
                spacing: 6,
                lineStyle: SkeletonLineStyle(
                  randomLength: true,
                  height: 10,
                  borderRadius: BorderRadius.circular(8),
                  minLength: MediaQuery.of(context).size.width / 2,
                ))),
            SizedBox(height: 20),
          
        
        
        


         
         
            ],
          ),
        ),
      );
  }
}
