

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKeyMarca = new GlobalKey<FormState>();
 final String _baseUrl = 'www.consola-sudsolutions.mx';
  String marca = '';
  String dispositivo='';
  String device='';
  String command='';
  String idmarca="Seleccione";
  String idPageDispositivo='';



  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }

  
  bool isValidFormMarca() {

    // print(formKey.currentState?.validate());

    // print('$marca');
    
    return formKeyMarca.currentState?.validate() ?? false;
  }


 

}