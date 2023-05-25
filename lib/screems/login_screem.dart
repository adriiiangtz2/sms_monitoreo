import 'package:flutter/material.dart';
import 'package:monitoreo_sms/screems/screems.dart';
import 'package:monitoreo_sms/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:monitoreo_sms/provider/provider.dart';
import 'package:monitoreo_sms/services/services.dart';
import 'package:monitoreo_sms/ui/ui.dart';
import 'package:monitoreo_sms/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthLogin(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 300,
              ),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('Iniciar Sesion',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (context) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    void displayDialogAndroid(BuildContext context) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                elevation: 5,
                title: const Text('Nombre de usuario incorrecto',
                    textAlign: TextAlign.center),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(20)),
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Parece que el nombre de usuario que has introducido no pertenece a ninguna cuenta. Comprueba tu nombre de usuario y vuelve a intertarlo.',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Center(child: Text('vuelva a intentarlo'))),
                ],
              ));
    }

    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: InputDecorations.authInputDecoration(
                hintText: "Usuario",
                labelText: "Nombre de usuario",
                prefixIcon: Icons.face),
            onChanged: (value) => loginForm.name = value,
            validator: (value) =>
                (value == "") ? "Ingrese nombre de usuario" : null,
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintText: "*****",
                labelText: "Contraseña",
                prefixIcon: Icons.lock_outline),
            onChanged: (value) => loginForm.password = value,
            validator: (value) =>
                (value == "") ? "Ingrese una contraseña" : null,
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: AppTheme.primary,
            // ignore: sort_child_properties_last
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading ? 'Espere' : 'Ingresar',
                  style: const TextStyle(color: Colors.white),
                )),
            //para bloquear el boton poner null
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    //ocultar telcado al dar press
                    FocusScope.of(context).unfocus();
                    //valiar y cambiar boton
                    if (!loginForm.isValidForm()) return;
                    //bloquear
                    loginForm.isLoading = true;
                    //simular peticion
                    // await Future.delayed(const Duration(seconds: 1));
                    //desbloquear
                    var name = loginForm.name;
                    var passs = loginForm.password;

                    name = name.trim();
                    name = name.replaceAll("\\s{2,}", " ");
                    passs = passs.trim();
                    passs = passs.replaceAll("\\s{2,}", " ");
                    // ignore: use_build_context_synchronously
                    await authService.authLogin(name, passs);

                    if (authService.inicioSesion == false) {
                      // ignore: use_build_context_synchronously
                      displayDialogAndroid(context);
                      loginForm.isLoading = false;
                    } else {
                      //  await marcas.marcasAll();
                      // await device.dispositivosTotal();

                      // await units.getUnits();
                      loginForm.isLoading = false;
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InicioScreen()));
                              // builder: (context) => const HomeScreen3()));
                    }
                  },
          )
        ],
      ),
    );
  }
}
