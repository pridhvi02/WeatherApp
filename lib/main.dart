import 'package:flutter/material.dart';
import 'package:weather_app/homescreen.dart';

void main() {
  runApp(MaterialApp(

    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.white,
        secondary: Colors.white,
      ),
    )

  ));
}
