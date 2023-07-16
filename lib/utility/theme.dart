import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFf3f4f6),
    fontFamily: "Manrope",
    primaryColor: Colors.black,
    appBarTheme: appBarTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

AppBarTheme appBarTheme() {
  return  const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    toolbarHeight: 44.0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 15),
  );
}
InputDecorationTheme inputDecorationTheme() {
   OutlineInputBorder outlineInputBorder =  OutlineInputBorder(
    borderRadius: BorderRadius.circular(0),
    borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
  );
  return  InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    hintStyle: const TextStyle(fontSize: 16, color: Color(0xFFC3C3C3)),
   // outlineBorder: null,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.fromLTRB(16,20,16,20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: null,
  );
}