import 'package:character_keeper/objects/character.dart';
import 'package:character_keeper/pages/home_page.dart';
import 'package:character_keeper/pages/page_select.dart';
import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider<Character_Provide>(
        create: (context) => Character_Provide(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red[800]!),
          textTheme: TextTheme(
              headline4: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              headline5: TextStyle(fontWeight: FontWeight.bold))),
    );
  }
}
