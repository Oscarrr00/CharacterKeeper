import 'package:character_keeper/items/input_text.dart';
import 'package:character_keeper/pages/characters_page.dart';
import 'package:character_keeper/pages/new_acount.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var usernameController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("D&D Character Keeper",
                  style: TextStyle(
                      fontSize: 49,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center),
              SizedBox(height: 10),
              InputText(
                  label: "Username",
                  hintText: "Username Here",
                  controller: usernameController,
                  color: Colors.white),
              InputText(
                  label: "Password",
                  hintText: "Password Here",
                  controller: passwordController,
                  color: Colors.white),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 30.0, left: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CharactersUser(),
                            ),
                          );
                        },
                        color: Color.fromARGB(255, 101, 26, 21),
                        child: Text("Login",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 30.0, left: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => NewAcount(),
                            ),
                          );
                        },
                        child: Text("Create New Acount",
                            style: TextStyle(color: Colors.white)),
                        color: Color.fromARGB(255, 102, 84, 84),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
