import 'package:character_keeper/pages/characters_page.dart';
import 'package:character_keeper/pages/home_page.dart';
import 'package:character_keeper/providers/character_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckAuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return CharactersUser();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Algo salio mal"),
                );
              } else {
                return HomePage();
              }
            }));
  }
}
