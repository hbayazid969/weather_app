import 'package:flutter/material.dart';
import 'package:weather_forcast/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forcast',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
