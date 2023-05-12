import 'package:flutter/material.dart';
import 'package:monitoreo_sms/models/models.dart';
import 'package:monitoreo_sms/provider/provider.dart';
import 'package:monitoreo_sms/services/services.dart';
import 'package:monitoreo_sms/theme/app_theme.dart';
import 'package:monitoreo_sms/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

class TypesCommandScreen extends StatelessWidget {
   
  const TypesCommandScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    

     final marca= Provider.of<CommandService>(context, listen: false);
                    // await ;

    void displayDialogAndroid(BuildContext context) {
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 5,
              title: const Text('Nuevo Nombre de Comando', textAlign: TextAlign.center),
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
                      child: const _formTypeCommand(),
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
        title: const Text("Tipos de comandos"),
        backgroundColor: AppTheme.primary,
      ),
      
    floatingActionButton: FloatingActionButton(
        onPressed: () {
          displayDialogAndroid(context);
        },
        // backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      drawer: const SideMenu(),
       body:FutureBuilder(
        future:marca.commandsAll() ,
        builder: (context, snapshot) {

          // print(snapshot.data);

          if(snapshot.hasData){
              return const _contentInfo();
          }else{
            return const skeletonLoadingTypes();
          }
          


        },),
    );
  }


  
}

class _contentInfo extends StatelessWidget {
  const _contentInfo({
    Key? key,
    // required this.comandosType,
  }) : super(key: key);

  // final List comandosType;

  @override
  Widget build(BuildContext context) {

    // return Container(
    //   child: _listViewCommandType(comandosType: comandosType),
    // );
    final commandAll = Provider.of<CommandService>(context);
    
    List comandosType = commandAll.commandArray;


    return ChangeNotifierProvider(create:(context) => DispositivosService(),
         child: _listViewCommandType(comandosType: comandosType),
        );
  }
}

class _listViewCommandType extends StatelessWidget {
  const _listViewCommandType({
    Key? key,
    required this.comandosType,
  }) : super(key: key);

  final comandosType;
   void displayEditar(BuildContext context , marca) {
  // print(listMarca);;
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 5,
              title: const Text('Editar nombre de comando', textAlign: TextAlign.center),
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
                      child: _formMarcaEdit(data:marca),
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

    void displayEliminarDevice(BuildContext context , comando) {
  // print(listMarca);;
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 5,
              title: const Text('Eliminar nombre Comando', textAlign: TextAlign.center),
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
                      child: _formComandoDelete(data:comando),
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
    return ListView.builder(
      padding: const EdgeInsets.only(left: 5, right: 10, bottom: 70, top: 5),
      itemCount: comandosType.length,
      itemBuilder:(context, index) {
        print(comandosType.length);

        // final Devices oneDevice =  device[index];
        final  Command comandType = comandosType[index];
        // print(comandType.cdComando)
        return Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(comandType.cdComando, style: const TextStyle(fontSize: 20)),
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
      
                      displayEditar(context , comandType);
                    },
                    color: AppTheme.primary,
                    child: const Text('EDITAR',
                        style: TextStyle(color: Colors.white)),
                  ),
                  MaterialButton(
                    minWidth: 100,
                    height: 35,
                    onPressed: () {
      
                      displayEliminarDevice(context , comandType);
      
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


class _formTypeCommand extends StatelessWidget {
  const _formTypeCommand({
    Key? key,
    Key? marca,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<FormProvider>(context);
    final commandService = Provider.of<CommandService>(context);
    return Form(
      key: registerForm.formKeyMarca,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade300,
              labelText: 'Agregar Nombre de Comando',
            ),
            onChanged: (value) => registerForm.command = value,
            validator: (value) => (value == "") ? "Ingrese un nombre" : null,
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
                  registerForm.isLoading ? 'Registrando' : 'Registra',
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

                    print(registerForm.command);
                    await commandService.createNameCommand(registerForm.command);

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


class _formMarcaEdit extends StatelessWidget {
    final Command data;
   _formMarcaEdit({
    required this.data

   });

  // MarcaGps marca;



  @override
  Widget build(BuildContext context) {
    print(data.cdComando);
      // print(wi)

    // print(marca);
    final registerForm = Provider.of<FormProvider>(context);
    final comanTypeserive = Provider.of<CommandService>(context);
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
            initialValue: data.cdComando,
            
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
                    
                    print("marca: ${registerForm.command}");
                    print(data.cdComando);
                    await comanTypeserive.editNameCommand(registerForm.command, data.idComando);

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

class skeletonLoadingTypes extends StatelessWidget {
  const skeletonLoadingTypes({
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

class _formComandoDelete extends StatelessWidget {
    final Command data;
   _formComandoDelete({
    required this.data

   });

  // MarcaGps marca;



  @override
  Widget build(BuildContext context) {
    // print(data.mcMarca);
      // print(wi)

    // print(marca);
    final registerForm = Provider.of<FormProvider>(context);
    final comandSerive = Provider.of<CommandService>(context);
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
            
            onChanged: (value) => registerForm.device = value,
            validator: (value) => (registerForm.device == "ELIMINAR") ? null:"Ingrese ELIMINAR" ,
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

                    print(registerForm.device);
                    print(data.idComando);

                    await comandSerive.deleteNameCommand(data.idComando);
                    // await deviceSerive.deleteDevice(data.idDispositivo , data.marca.idMarca);
                    



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

