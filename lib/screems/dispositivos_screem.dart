import 'package:flutter/material.dart';
import 'package:monitoreo_sms/models/models.dart';
import 'package:monitoreo_sms/provider/provider.dart';
import 'package:monitoreo_sms/services/services.dart';
import 'package:monitoreo_sms/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

class DispositivosScreen extends StatelessWidget {
   
  const DispositivosScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final dispositivos = Provider.of<DispositivosService>(context , listen: false);
    // var device = dispositivos.devicesArray;

     final routName = ModalRoute.of(context)!.settings.arguments;
    //  print(routName);

    return  Scaffold(
       appBar: AppBar(
        title: const Text("Dispositivos"),
        backgroundColor: AppTheme.primary,
      ),

      body:  FutureBuilder(
        future:  dispositivos.dispositivosAll(routName),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return  ContentDevice();          
            }else{

              return const _skeletonLoadingDevice();
            }

        
      },),
      
      
      
      
      // ContentDevice(device: device),
    );
  }
}

class ContentDevice extends StatelessWidget {
  const ContentDevice({
    Key? key,
    // required this.device,
  }) : super(key: key);

  // final List device;

  @override
  Widget build(BuildContext context) {

     final dispositivos = Provider.of<DispositivosService>(context );
    var device = dispositivos.devicesArray;

    return ChangeNotifierProvider(create:(context) => DispositivosService(),
    child: _listViewDevices(device: device),
    );
  }
}

class _listViewDevices extends StatelessWidget {
  const _listViewDevices({
    Key? key,
    required this.device,
  }) : super(key: key);

  final List device;



  void displayEditarDevice(BuildContext context , device) {
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
                      child: _formDeviceEdit(data:device),
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
void displayEliminarDevice(BuildContext context , marca) {
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
                      child: _formDeviceDelete(data:marca),
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

    final comandoss = Provider.of<CommandService>(context , listen: false);
     final registerForm = Provider.of<FormProvider>(context , listen: false);
      final marca= Provider.of<CommandService>(context, listen: false);
    return ListView.builder(
      padding: const EdgeInsets.only(left: 5, right: 10, bottom: 70, top: 5),
      itemCount: device.length,
      itemBuilder:(context, index) {

        final Devices oneDevice =  device[index];
        final  comand = oneDevice.dvComandos;
        // print("ddddddddddddddddd");
        // print(oneDevice.idDispositivo);
        // print('#########${oneDevice.idDispositivo}############# ');
        
  
        return GestureDetector(
        onTap: () async {
  
          final String idDevice = "${oneDevice.idDispositivo}";

           Navigator.of(context).pushNamed('command', arguments: idDevice );
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.gps_fixed, size: 80 , color:AppTheme.primary ),
                Text("${oneDevice.dvDispositivo}", style: const TextStyle(fontSize: 20)),
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
                        // print(oneDevice)

      
                        displayEditarDevice(context ,oneDevice );
                      },
                      color: AppTheme.primary,
                      child: const Text('EDITAR',
                          style: TextStyle(color: Colors.white)),
                    ),

                    MaterialButton(
                      minWidth: 100,
                      height: 35,
                      onPressed: () async{
                        final check = await comandoss.commandVerificar("${oneDevice.idDispositivo}");
                        if(check) {
                          print('Entro');
                        displayEliminarDevice(context , oneDevice);

                        }else{
                          return  showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 5,
              title: const Text('Eliminar comandos', textAlign: TextAlign.center),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(20)),
              content: SizedBox(
                width: 10,
                child: Text("Para eliminar este dispositivo primero se tienen que eliminar los comandos registrados"),
             
              ),
              actions: const [
                // TextButton(
                //     onPressed: () => Navigator.pop(context),
                //     child: const Center(child: Text('vuelva a intentarlo'))),
              ],
            );
          });

                        }
      
                      },
                      color: const Color.fromARGB(255, 149, 8, 8),
                      child: const Text('ELIMINAR',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
        
      },
      
      );
  }
}

class _formDeviceEdit extends StatelessWidget {
    final Devices data;
   _formDeviceEdit({
    required this.data

   });

  // MarcaGps marca;



  @override
  Widget build(BuildContext context) {
    // print(data.dvDispositivo);
      // print(wi)

    // print(marca);
    final registerForm = Provider.of<FormProvider>(context);
    final deviceSerive = Provider.of<DispositivosService>(context);
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
            initialValue: data.dvDispositivo,
            
            onChanged: (value) => registerForm.device = value,
            validator: (value) => ( (value == "")||(registerForm.device =="") ) ? "Favor editar" : null,
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
                    
                    print("marca: ${registerForm.device}");
                    print(data.idDispositivo);
                    print(data.marca.idMarca);
                    await deviceSerive.editDevice("${registerForm.device}", data.idDispositivo ,data.marca.idMarca );

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

class _formDeviceDelete extends StatelessWidget {
    final Devices data;
   _formDeviceDelete({
    required this.data

   });

  // MarcaGps marca;



  @override
  Widget build(BuildContext context) {
    // print(data.mcMarca);
      // print(wi)

    // print(marca);
    final registerForm = Provider.of<FormProvider>(context);
    final deviceSerive = Provider.of<DispositivosService>(context);
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
            
            onChanged: (value) => registerForm.device = value.trim().replaceAll("\\s{2,}", " "),
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
                    print(data.idDispositivo);
                    await deviceSerive.deleteDevice(data.idDispositivo , data.marca.idMarca);
                    



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


class _skeletonLoadingDevice extends StatelessWidget {
  const _skeletonLoadingDevice({
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
