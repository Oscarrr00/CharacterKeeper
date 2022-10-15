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
        body: SafeArea(
      child: Column(
        children: [
          Text("D&D Character Keeper",
              style: TextStyle(fontSize: 49, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          Image.asset("assets/images/main_image.jpg"),
          SizedBox(height: 10),
          InputText(
              label: "Username",
              hintText: "Username Here",
              controller: usernameController),
          InputText(
              label: "Password",
              hintText: "Password Here",
              controller: passwordController),
          SizedBox(height: 25),
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
                    child: Text("Login"),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 45),
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
                    child: Text("Create New Acount"),
                    color: Colors.grey,
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
