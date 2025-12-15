// import 'package:flutter/material.dart';
//
// void main(){
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context){
//     return MaterialApp(
//    home: Scaffold(
//      // body : Text("Hello world"),
//      body : Center(
//        child:Text("India is the winner of t20 wc 2026"),
//      ),
//    ),
//     );
//   }
//
// }

import 'package:flutter/material.dart';
import 'weather_screen.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData.dark(),
      home: const WeatherScreen(),
    );
  }
}
