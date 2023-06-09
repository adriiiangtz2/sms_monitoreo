import 'package:flutter/material.dart';
import 'package:monitoreo_sms/models/unitsNew.dart';
import 'package:monitoreo_sms/screems/login_screem.dart';
import 'package:monitoreo_sms/screems/tab2_page.dart';
import 'package:monitoreo_sms/services/services.dart';
import 'package:monitoreo_sms/theme/ModelTheme.dart';
import 'package:monitoreo_sms/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:http/http.dart' as http;
import 'package:monitoreo_sms/widgets/widgets.dart';

import 'package:skeletons/skeletons.dart';


import 'package:flutter/material.dart';


class InicioScreen extends StatelessWidget {

  @override
 Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context) => _NavegacionModel(),
      child: Scaffold(
        body:_Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion();
  @override
  Widget build(BuildContext context) {
  final navegacionModel = Provider.of<_NavegacionModel>(context);
 
  // navegacionModel._paginaActual;
  // print(navegacionModel.paginaActual);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (value) => navegacionModel.paginaActual=value,
      items:
    const [
      BottomNavigationBarItem(icon:Icon(Icons.gps_fixed ) , label:"Wialom",activeIcon:Icon(Icons.gps_fixed , color: AppTheme.primary  )),
      BottomNavigationBarItem(icon:Icon(Icons.gps_fixed ) , label:"Mapon" , activeIcon:Icon(Icons.gps_fixed , color: AppTheme.primary )),
    ] 
    );
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas();

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);


    return PageView(
      controller: navegacionModel.pageController,
      physics: const NeverScrollableScrollPhysics(),

    //  physics: BouncingScrollPhysics(),
     children: [
      HomeScreen3(),
      // HomeScreen3(),
      TapPage2(),

     ],
    );
  }
}


class _NavegacionModel with ChangeNotifier {

    int _paginaActual=0;
    PageController _pageController = new PageController(initialPage: 0);


    int get paginaActual => _paginaActual;
    set paginaActual(int valor){
      _paginaActual=valor;
      _pageController.animateToPage(valor,duration: Duration(milliseconds: 250), curve: Curves.easeInCirc);
      notifyListeners();
    }

    PageController get pageController => _pageController;

  
}


class HomeScreen3 extends StatelessWidget {
  const HomeScreen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final themeNotifier = Provider.of<ModelTheme>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unidades'),
        actions: [
          IconButton(
              icon: const Icon(Icons.call),
              onPressed: () async {
                const number = '5525813347';
                await FlutterPhoneDirectCaller.callNumber(number);
              }),
          IconButton(
              icon: Icon(themeNotifier.isDark
                  ? Icons.nightlight_round_outlined
                  : Icons.wb_sunny),
              onPressed: () {
                themeNotifier.isDark
                    ? themeNotifier.isDark = false
                    : themeNotifier.isDark = true;
              }),
          IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () async {
                //Eliminando Storage
                await authService.logaut();
                // Navigator.pushNamed(context, 'login');
                themeNotifier.isDark = false;
                // Navigator.of(context).pushNamed('login');
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              }),
        ],
      ),
      drawer: const SideMenu(),
      body: RefreshIndicator(
        onRefresh: () async {
          await authService.refreshList();
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InicioScreen()));
        },
        child: FutureBuilder(
          future: UnitsService.getAllUnits(),
          builder: (context, snapshot) => (snapshot.hasData) ?  ContentListView2(unidades: snapshot.data) : const _skeletonLoading(),
        ),
      ),
    );
  }
}

// ignore: camel_case_types

class ContentListView2 extends StatefulWidget {
  const ContentListView2({
    Key? key,
    required this.unidades,
  }) : super(key: key);

  final List unidades;

  @override
  State<ContentListView2> createState() => _ContentListViewState();
}

class _ContentListViewState extends State<ContentListView2> {
  
  List unidadesAll = [];
  final myControllerr = TextEditingController();

  @override
  initState() {
    unidadesAll = widget.unidades;
    super.initState();
  }

  _clearInput() {
    myControllerr.text = "";
    var pruebaArreglo2 = [];
    pruebaArreglo2 = widget.unidades;
    setState(() {
      unidadesAll = pruebaArreglo2;
    });
  }

  @override
  Widget build(BuildContext context) {

    errorImg(String imagen, DataUnits value) async {
      if (value.imgLoad == true) return imagen;
      if (value.imgLoad == false) return "Error";

      final response = await http.get(Uri.parse(imagen));
      
      if (response.body == "404 Not Found" || response.body == "") {
        value.imgLoad = false;
        return "Error";
      } else {
        value.imgLoad = true;
        return value.image;
      }
    }

    // ignore: no_leading_underscores_for_local_identifiers
    _runFilterUnits(String value) { 
      var pruebaArreglo2 = [];
      //  print("value: $value");
      if (value.isEmpty) {
        // print("Entra sin valor");
        pruebaArreglo2 = widget.unidades;
        setState(() {
          unidadesAll = pruebaArreglo2;
        });
      }
      if (value.isNotEmpty) {
        unidadesAll = widget.unidades;
        // print("Entra con valor");
        for (var i = 0; i < unidadesAll.length; i++) {
          final DataUnits uni = unidadesAll[i];
          final name = uni.name.toLowerCase();
          final input = value.toLowerCase();
          if (name.contains(input)) {
            pruebaArreglo2.add(uni);
            // print(uni.name);
          }
        }
        setState(() {
          unidadesAll = pruebaArreglo2;
        });
        // print(pruebaArreglo2.length);
      }
    }
    //  String _searchText = "";
    // TextEditingController _searchController;

    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: TextField(
            controller: myControllerr,
            //  controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search,
                color: AppTheme.primary,
              ),
              filled: true,
              // fillColor: Colors.grey.shade300,
              labelText: 'Buscar unidad por nombre',
              // fillColor: Colors.black

              suffixIcon: myControllerr.text.isEmpty
                  ? null
                  : InkWell(
                      onTap: () => _clearInput(),
                      child: const Icon(Icons.clear),
                    ),
              //      suffix: IconButton(
              // icon: Icon(Icons.clear),
              // onPressed: () {
              //   _clearInput();

              //  },
              //     ),
            ),
            onChanged: (value) => _runFilterUnits(value),
          ),
        ),
        Expanded(
            child: ListView.builder(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 70, top: 10),
          itemCount: unidadesAll.length,
          itemBuilder: (context, index) {
            final DataUnits value = unidadesAll[index];

            // print(value.hardware);

            return Card(
              elevation: 3,
              child: ListTile(
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    // child: unidad['uri'] == null || unidad['uri'] == ""  ?
                    child: Container(
                      width: 34,
                      child: FutureBuilder(
                        future: errorImg("${unidadesAll[index].image}", value),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                            // return  Text("");
                          }
                          // print(snapshot.data);
                          if (snapshot.data == "Error") {
                            return const SizedBox(
                                height: 30,
                                width: 28,
                                child: Icon(
                                  Icons.image_not_supported_rounded,
                                  color: Color.fromARGB(136, 214, 214, 214),
                                  size: 30,
                                ));
                            // fit: BoxFit.scaleDown,
                            // width:50,
                            // height: 50,
                            //   );;
                          } else {
                            return Image.network(
                              "${snapshot.data}",
                              fit: BoxFit.scaleDown,
                              width: 28,
                              height: 30,
                            );
                          }
                        },
                      ),
                    )),
                onTap: () async {
                  // final authService = Provider.of<AuthService>(context, listen: false);

                  //  final device= Provider.of<DispositivosService>(context, listen: false);
                  //  print("click ${unidadesAll[index].id}");
                  // await units.getOnetUnit(unidadesAll[index].id);

                  // await device.dispositivosAll(idMarca);
                  // await device.dispositivosTotal();
                  // ignore: use_build_context_synchronously
                  // Navigator.pushNamed(context, 'datails', arguments: unidadesAll[index].id);
                  Navigator.of(context)
                      .pushNamed('datails2', arguments: unidadesAll[index].id);
                },
                title: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(unidadesAll[index].name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 13)),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${unidadesAll[index].id}",
                          style: const TextStyle(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: 13)),
                      Text("Hardware: ${unidadesAll[index].hardware}")
                    ],
                  ),
                ),
                trailing: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
        )),
        SizedBox(height: 10,),


//       BottomNavigationBar(
//          backgroundColor: AppTheme.primary,
//          elevation: 0,
//   selectedFontSize: 15,
//   selectedIconTheme: IconThemeData(color: Colors.white, size: 15),
//   selectedItemColor: AppTheme.primary,
//   selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
//   items: const <BottomNavigationBarItem>[
//     BottomNavigationBarItem(
//       icon: Icon(Icons.car_crash),
//       label: 'wialom'
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.car_crash),
//       label: 'Mapon'
//     ),
    
//   ],
// )







        
      ],
    );
  }
}


// ignore: camel_case_types
class _skeletonLoading extends StatelessWidget {
  const _skeletonLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      // width: 300,
      child: SingleChildScrollView(
        child: Column(children: [
          Row(
            children: [
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                    height: 70, width: MediaQuery.of(context).size.width - 20),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              SkeletonAvatar(style: SkeletonAvatarStyle(height: 60, width: 60)),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  SkeletonLine(
                      style: SkeletonLineStyle(width: 100, height: 10)),
                  SizedBox(
                    height: 3,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(width: 100, height: 10),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(width: 150, height: 10),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              SkeletonAvatar(style: SkeletonAvatarStyle(height: 60, width: 60)),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  SkeletonLine(
                      style: SkeletonLineStyle(width: 100, height: 10)),
                  SizedBox(
                    height: 3,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(width: 100, height: 10),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(width: 150, height: 10),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              SkeletonAvatar(style: SkeletonAvatarStyle(height: 60, width: 60)),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  SkeletonLine(
                      style: SkeletonLineStyle(width: 100, height: 10)),
                  SizedBox(
                    height: 3,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(width: 100, height: 10),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(width: 150, height: 10),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              SkeletonAvatar(
                  style: SkeletonAvatarStyle(height: 60, width: 60)),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  SkeletonLine(
                      style: SkeletonLineStyle(width: 100, height: 10)),
                  SizedBox(
                    height: 3,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(width: 100, height: 10),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(width: 150, height: 10),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              SkeletonAvatar(style: SkeletonAvatarStyle(height: 60, width: 60)),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  SkeletonLine(
                      style: SkeletonLineStyle(width: 100, height: 10)),
                  SizedBox(
                    height: 3,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(width: 100, height: 10),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(width: 150, height: 10),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              SkeletonAvatar(style: SkeletonAvatarStyle(height: 60, width: 60)),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  SkeletonLine(
                      style: SkeletonLineStyle(width: 100, height: 10)),
                  SizedBox(
                    height: 3,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(width: 100, height: 10),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(width: 150, height: 10),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              SkeletonAvatar(style: SkeletonAvatarStyle(height: 60, width: 60)),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  SkeletonLine(
                      style: SkeletonLineStyle(width: 100, height: 10)),
                  SizedBox(
                    height: 3,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(width: 100, height: 10),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(width: 150, height: 10),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              SkeletonAvatar(style: SkeletonAvatarStyle(height: 60, width: 60)),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  SkeletonLine(
                      style: SkeletonLineStyle(width: 100, height: 10)),
                  SizedBox(
                    height: 3,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(width: 100, height: 10),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(width: 150, height: 10),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              SkeletonAvatar(style: SkeletonAvatarStyle(height: 60, width: 60)),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  SkeletonLine(
                      style: SkeletonLineStyle(width: 100, height: 10)),
                  SizedBox(
                    height: 3,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(width: 100, height: 10),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(width: 150, height: 10),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
