
import 'package:flutter/material.dart';

class AppTheme {

  // static const Color primary = Colors.teal;
  static const Color primary = Color(0xFD154072);
  static const Color secundaryBlack = Colors.black;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    // primaryColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0
    ),

    // primaryColorLight: Colors.black12 ,
    // listTileTheme: ListTileThemeData(
    //   textColor: Colors.black,
    //   ),
      // textTheme: TextTheme(),
      // expansionTileTheme:ExpansionTileThemeData(textColor: Colors.black,
      // // collapsedTextColor:Colors.black, 
      // ) ,

  
 

    // switchTheme: SwitchThemeData(
    //   trackColor: Colors.accents,
    // ) ,

    // Texbutton theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primary),
    ),

    // scaffoldBackgroundColor: Colors.black,

    // FloatingActionButtos

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      elevation: 5
    ),

    // ElevatedButton 
    elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
          primary: primary,
          shape: const StadiumBorder(),
          elevation: 0
        ),
    ),

    
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle( color: primary ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide( color: primary ),
        borderRadius: BorderRadius.only( bottomLeft: Radius.circular(10), topRight: Radius.circular(10) )
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide( color: primary ),
        borderRadius: BorderRadius.only( bottomLeft: Radius.circular(10), topRight: Radius.circular(10) )
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.only( bottomLeft: Radius.circular(10), topRight: Radius.circular(10) )
      ),

    )


  );
}