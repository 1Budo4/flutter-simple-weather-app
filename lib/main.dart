import 'package:flutter/material.dart';
import 'package:simple_weather_app/pages/weather_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
      theme: ThemeData(textTheme: GoogleFonts.robotoMonoTextTheme()),
    );
  }
}
