import 'package:character_keeper/items/input_text.dart';
import 'package:character_keeper/pages/characters_page.dart';
import 'package:character_keeper/pages/new_acount.dart';
import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var usernameController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.only(top: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            color: Theme.of(context).colorScheme.primaryContainer,
            'assets/images/dado.png',
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 3,
          ),
          Text("D&D CHARACTER KEEPER",
              style: TextStyle(
                fontSize: 26,
                fontFamily: "Araboto",
              ),
              textAlign: TextAlign.center),
          SizedBox(height: 10),
          InputText(
              label: "E-MAIL",
              hintText: "E-mail Here",
              controller: usernameController,
              color: Theme.of(context).colorScheme.tertiary),
          InputText(
              label: "PASSWORD",
              hintText: "Password Here",
              controller: passwordController,
              color: Theme.of(context).colorScheme.tertiary),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(right: 30.0, left: 30),
            child: Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    onPressed: () {
                      context.read<Character_Provide>().loginUser(
                          usernameController.text, passwordController.text);
                    },
                    color: Theme.of(context).colorScheme.primary,
                    child: Text("Login", style: TextStyle(color: Colors.white)),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text("Create New Acount",
                        style: TextStyle(color: Colors.white)),
                    color: Theme.of(context).colorScheme.tertiary,
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
