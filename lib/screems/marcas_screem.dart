import 'package:flutter/material.dart';
import 'package:monitoreo_sms/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:monitoreo_sms/widgets/widgets.dart';
import 'package:monitoreo_sms/models/models.dart';
import 'package:monitoreo_sms/provider/provider.dart';
import 'package:monitoreo_sms/services/services.dart';
import 'package:skeletons/skeletons.dart';

class MarcasScreen extends StatelessWidget {
  const MarcasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  

     final marca= Provider.of<MarcaService>(context, listen: false);

    void createMarcaDisplay(BuildContext context) {
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 5,
              title: const Text('Nueva Marca', textAlign: TextAlign.center),
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
                      child: const _formMarca(),
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
        title: const Text("Marcas y Dispositivos"),
        backgroundColor: AppTheme.primary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createMarcaDisplay(context);
        },
        // backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      drawer: const SideMenu(),
      body: FutureBuilder(
        future:  marca.marcasAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const _contentMarcas();          
            }else{

              return const skeletonLoadingMarcas();
            }

        
      },),
    );
  }
}

class _contentMarcas extends StatelessWidget {
  const _contentMarcas({
    Key? key,
    // required this.listMarca,
  }) : super(key: key);

  // final List listMarca;

  @override
  Widget build(BuildContext context) {

      final marcasAll = Provider.of<MarcaService>(context , listen: false);
    
    List listMarca = marcasAll.marcaArray;
    return ChangeNotifierProvider(
      create: (context) => MarcaService(),
      child: _listViewMarcas(listMarca: listMarca),
    );
  }
}

class _listViewMarcas extends StatelessWidget {
  const _listViewMarcas({
    Key? key,
    required this.listMarca,
  }) : super(key: key);
  final List listMarca;



void displayEditar(BuildContext context , marca) {
  // print(listMarca);;
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 5,
              title: const Text('Editar Marca', textAlign: TextAlign.center),
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


void displayEliminar(BuildContext context , marca) {
  // print(listMarca);;
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 5,
              title: const Text('Eliminar Marca', textAlign: TextAlign.center),
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
                      child: _formMarcaDelete(data:marca),
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
final dispositivos = Provider.of<DispositivosService>(context ,listen: false);

    return ListView.builder(
      padding: const EdgeInsets.only(left: 5, right: 10, bottom: 70, top: 5),
      itemCount: listMarca.length,
      itemBuilder: (context, index) {
        final MarcaGps marca = listMarca[index];
        // print(marca.idMarca);

        return GestureDetector(
          onTap: () async {
            
           

            await   dispositivos.dispositivosAll(marca.idMarca);
            // print("Pres");


             // ignore: use_build_context_synchronously
             Navigator.of(context).pushNamed('dispositivos' ,arguments: marca.idMarca);
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.travel_explore_rounded , size:80 , color: AppTheme.primary,),
                  Text(marca.mcMarca, style: const TextStyle(fontSize: 20)),
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
        
                          displayEditar(context , marca);
                        },
                        color: AppTheme.primary,
                        child: const Text('EDITAR',
                            style: TextStyle(color: Colors.white)),
                      ),
                      MaterialButton(
                        minWidth: 100,
                        height: 35,
                        onPressed: () {
        
                          displayEliminar(context , marca);
        
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

class _formMarca extends StatelessWidget {
  const _formMarca({
    Key? key,
    Key? marca,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<FormProvider>(context);
    final marcaserive = Provider.of<MarcaService>(context);
    return Form(
      key: registerForm.formKeyMarca,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade300,
              labelText: 'Agregar Marca',
            ),
            onChanged: (value) => registerForm.marca = value,
            validator: (value) => (value == "") ? "Ingrese Una marca" : null,
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

                    print(registerForm.marca);
                    await marcaserive.createMarca(registerForm.marca);

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
    final MarcaGps data;
   _formMarcaEdit({
    required this.data

   });

  // MarcaGps marca;



  @override
  Widget build(BuildContext context) {
    print(data.mcMarca);
      // print(wi)

    // print(marca);
    final registerForm = Provider.of<FormProvider>(context);
    final marcaserive = Provider.of<MarcaService>(context);
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
            initialValue: data.mcMarca,
            
            onChanged: (value) => registerForm.marca = value,
            validator: (value) => ( (value == "")||(registerForm.marca =="") ) ? "Favor editar" : null,
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
                    
                    print("marca: ${registerForm.marca}");
                    print(data.idMarca);
                    await marcaserive.editMarca(registerForm.marca, data.idMarca);

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
class _formMarcaDelete extends StatelessWidget {
    final MarcaGps data;
   _formMarcaDelete({
    required this.data

   });

  // MarcaGps marca;



  @override
  Widget build(BuildContext context) {
    // print(data.mcMarca);
      // print(wi)

    // print(marca);
    final registerForm = Provider.of<FormProvider>(context);
    final marcaserive = Provider.of<MarcaService>(context);
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
            
            onChanged: (value) => registerForm.marca = value,
            validator: (value) => (registerForm.marca == "ELIMINAR") ? null:"Ingrese ELIMINAR" ,
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

                    print(registerForm.marca);
                    // print(data.idMarca);
                    await marcaserive.deleteMarca(registerForm.marca, data.idMarca);

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


class skeletonLoadingMarcas extends StatelessWidget {
  const skeletonLoadingMarcas({
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
