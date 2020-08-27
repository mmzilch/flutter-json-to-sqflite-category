import 'package:flutter/material.dart';
import 'package:flutter_healthy_fitness/screen/home_screen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomeScreen(),
      },
    );
  }
}
