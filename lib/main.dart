import 'package:flutter/material.dart';
import 'package:weather_app/pages/screen_one.dart';
import 'package:weather_app/splash_screen.dart';
import 'package:weather_app/weather_screen.dart';
import 'package:weather_app/welcome_screen.dart';
// import 'package:weather_app/mobile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData.light(),
      home: SplashScreen(),
    );
  }
}
