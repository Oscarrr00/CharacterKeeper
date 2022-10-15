import 'package:character_keeper/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      //home: HomePage(),
      home: HomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red[800]!),
        textTheme: TextTheme(
          headline4: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
          headline5: TextStyle(fontWeight: FontWeight.bold)
        )
      ),
    );
  }
}
