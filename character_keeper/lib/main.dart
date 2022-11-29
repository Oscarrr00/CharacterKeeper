import 'package:character_keeper/pages/check_auth_page.dart';
import 'package:character_keeper/pages/note_page.dart';
import 'package:character_keeper/providers/character_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider<Character_Provide>(
      create: (context) => Character_Provide(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: NotePage(),
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


