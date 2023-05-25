import 'package:flutter/material.dart';
import 'package:monitoreo_sms/models/mapo_units.dart';
import 'package:monitoreo_sms/models/unitsNew.dart';
import 'package:monitoreo_sms/screems/home_screem_copy.dart';
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

class TapPage2 extends StatelessWidget {
  const TapPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final themeNotifier = Provider.of<ModelTheme>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unidades Mapon'),
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
          await authService.refreshListMapon();
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InicioScreen()));
        },
        child: FutureBuilder(
          future: UnitsService.getAllUnitsMapon(),
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

    errorImg( String imagen , MaponUnits value) async {
     if (value.imgLoad == true) return imagen;
      if (value.imgLoad == false) return "Error";

      final response = await http.get(Uri.parse(imagen));
      
      if (response.body == "404 Not Found" || response.body == "") {
        value.imgLoad = false;
        return "Error";
      } else {
        value.imgLoad = true;
        return value.name;
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
          final MaponUnits uni = unidadesAll[i];
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
            final MaponUnits value = unidadesAll[index];

            print(value);

            return Card(
              elevation: 3,
              child: SizedBox(
                width: double.infinity,
                child: ListTile(
                  leading: const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Icon(
                                    Icons.image_not_supported_rounded,
                                    color: Colors.grey,
                                    size: 30,
                                  )),
                  onTap: ()  {
                    Navigator.of(context).pushNamed('datailsMapon', arguments: value.unitId);
                  },
                  title: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(value.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 13)),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${value.unitId}",
                            style: const TextStyle(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 13)),
                        Text("Hardware: ${value.boxId}")
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
              ),
            );
         
          },
        )),
        SizedBox(height: 10,),        
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
