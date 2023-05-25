import 'package:flutter/material.dart';
import 'package:monitoreo_sms/screems/screems.dart';
import 'package:monitoreo_sms/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:monitoreo_sms/services/services.dart';


class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: ListView(
            children: [
              const _DrawerHeader(),
              ListTile(
                leading: const Icon(Icons.car_repair_sharp , color: AppTheme.primary),
                title: const Text('Unidades'),
                onTap: () {
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InicioScreen()));
                  // Navigator.pushNamed(context, 'home3');

                },
              ),
                  // const LinearProgressIndicator()
              ListTile(
                leading: const Icon(Icons.message , color: AppTheme.primary),
                title: const Text('Tipos de comandos'),
                onTap: () async {
                   
                Navigator.pushNamed(context, 'types');
                    // const LinearProgressIndicator();
                },
              ),
              ListTile(
                leading: const Icon(Icons.gps_fixed_outlined , color: AppTheme.primary),
                title: const Text('Marcas y dispositivos , Comandos'),
                onTap: () async {

                    // final authService = Provider.of<AuthService>(context, listen: false);
                    
                   
                    Navigator.pushNamed(context, 'marcas');
                },
              ),
            ],                
          ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      // ignore: sort_child_properties_last
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Monitorista : ', style:TextStyle(color: Colors.white, fontSize: 12 , fontWeight: FontWeight.w700),),
            Text('Url: www.consola-sudsolutions.mx',style:TextStyle(color: Colors.white, fontSize: 9)),
          ],
        ),
      ),
      decoration: const BoxDecoration(
        // image: DecorationImage(
        //   image: AssetImage('assets/logo.jpg'),
        //   fit: BoxFit.fitHeight,
          
        //   ),
          // borderRadius: BorderRadius.circular(10),
       gradient: LinearGradient(
        colors: [
           AppTheme.primary,
           Color.fromARGB(255, 165, 214, 254),
        ]
        )      
       ),
      );
  }
}