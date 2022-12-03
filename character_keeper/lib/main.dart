import 'package:character_keeper/pages/check_auth_page.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: CheckAuthPage(),
      theme: ThemeData(
          primaryColor: Color.fromRGBO(93, 13, 27, 1),
          scaffoldBackgroundColor: Color.fromARGB(255, 10, 13, 17),
          colorScheme: ColorScheme(
              brightness: Brightness.dark,
              primary: Color.fromRGBO(93, 13, 27, 1),
              primaryContainer: Color.fromRGBO(156, 22, 45, 1),
              onPrimary: Colors.white,
              secondary: Color.fromARGB(255, 21, 27, 35),
              onSecondary: Colors.white,
              tertiary: Color.fromARGB(255, 70, 75, 84),
              onTertiary: Colors.white,
              error: Colors.red,
              onError: Colors.orange,
              background: Color.fromRGBO(10, 13, 17, 1),
              onBackground: Color.fromRGBO(10, 13, 17, 1),
              surface: Color.fromRGBO(93, 13, 27, 1),
              onSurface: Colors.white),
          textTheme: TextTheme(
              headline3: TextStyle(
                  color: Color.fromARGB(255, 156, 159, 164),
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              bodyText1: TextStyle(
                  color: Color.fromARGB(255, 156, 159, 164),
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
              headline2: TextStyle(
                  color: Color.fromARGB(255, 156, 159, 164),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              headline6: TextStyle(
                  color: Color.fromARGB(255, 156, 159, 164),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              headline1: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(156, 22, 45, 1)),
              headline4: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              headline5: TextStyle(fontWeight: FontWeight.bold))),
    );
  }
}
