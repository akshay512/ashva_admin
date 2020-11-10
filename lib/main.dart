import 'package:flutter/material.dart';
import 'package:sampleLoginPage/screens/loginPage.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        textTheme: TextTheme(
            headline5:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}
