import 'package:flutter/material.dart';
import 'package:monitoreo_sms/screems/datails_screem_mapon.dart';
import 'package:monitoreo_sms/theme/ModelTheme.dart';
import 'package:monitoreo_sms/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:monitoreo_sms/provider/provider.dart';
import 'package:monitoreo_sms/screems/screems.dart';
import 'package:monitoreo_sms/services/services.dart';
// import 'package:toast/toast.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService(), lazy: false),
        ChangeNotifierProvider(create: (_) => UnistProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => MarcaService(), lazy: false),
        ChangeNotifierProvider(create: (_) => UnitsService(), lazy: false),
        ChangeNotifierProvider(create: (_) => FormProvider(), lazy: false),
        ChangeNotifierProvider(
            create: (_) => DispositivosService(), lazy: false),
        ChangeNotifierProvider(create: (_) => CommandService(), lazy: false),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    //  ToastContext().init(context);
    return ChangeNotifierProvider(
        create: (context) => ModelTheme(),
        child: Consumer<ModelTheme>(
            builder: (context, ModelTheme themeNotifier, child) {
          return MaterialApp(
            
            debugShowCheckedModeBanner: false,
            title: 'SMS App',
            initialRoute: 'checkAuth',
            routes: {
              'login': (_) => const LoginScreen(),
              'home': (_) => const HomeScreen(),
              'home2': (_) => const HomeScreen2(),
              'home3': (_) => const HomeScreen3(),
              'datails': (_) => const DatailsScreen(),
              'datails2': (_) => const DatailsScreen2(),
              'datailsMapon': (_) => const DatailsScreenMapon(),
              'types': (_) => const TypesCommandScreen(),
              'marcas': (_) => const MarcasScreen(),
              'dispositivos': (_) => const DispositivosScreen(),
              'checkAuth': (_) => const CheckAuthScreen(),
              'checklogin': (_) => const CheckLoginScreen(),
              'selects': (_) => const SelectsDispositivosCommandScreen(),
              'command': (_) => const CommandScreen(),
            },
            theme: themeNotifier.isDark
                ? ThemeData(
                  useMaterial3: true,
                    brightness: Brightness.dark,
                  )
                :    AppTheme.lightTheme ,
          );
        }));
  }
}
