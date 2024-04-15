import 'package:flutter/material.dart';

abstract class CustomThemeData{
  static ThemeData light(){
    return ThemeData(
        colorScheme: const ColorScheme.light(primary: Colors.deepPurple),
        primaryColor: Colors.deepPurple,
        primaryColorLight: Colors.tealAccent[700],
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 19,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis),
              iconTheme: IconThemeData(color: Colors.black)
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(15),
        )),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(15))),
      );
  }


  static ThemeData dark(){
    return ThemeData(
      colorScheme: const ColorScheme.dark(primary: Colors.deepPurple),
      primaryColor: Colors.deepPurple,
        primaryColorLight: Colors.tealAccent[700],
        appBarTheme:  AppBarTheme(
          color: Colors.grey[850],
          elevation: 0,
          titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(15),
        )),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(15))),
    );
  }
}
