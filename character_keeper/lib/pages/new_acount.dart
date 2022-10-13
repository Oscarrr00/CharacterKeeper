import 'package:character_keeper/items/input_text.dart';
import 'package:character_keeper/pages/characters_page.dart';
import 'package:flutter/material.dart';

class NewAcount extends StatelessWidget {
  const NewAcount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var newUsernameController = TextEditingController();
    var emailController = TextEditingController();
    var newPasswordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    return Scaffold(
        appBar: AppBar(title: Text("Create a new acount")),
        body: Column(
          children: [
            SizedBox(height: 10),
            InputText(
                label: "Choose a username",
                hintText: "New username",
                controller: newUsernameController),
            InputText(
                label: "Enter an email",
                hintText: "email@email.com",
                controller: emailController),
            SizedBox(height: 80),
            Text("Choose a password", style: TextStyle(fontSize: 19)),
            Text("It must be at least 8 characters long",
                style: TextStyle(fontSize: 19)),
            InputText(
                label: "",
                hintText: "New password",
                controller: newPasswordController),
            InputText(
                label: "",
                hintText: "Confirm new password",
                controller: confirmPasswordController),
            SizedBox(height: 60),
            MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CharactersUser(),
                    ),
                  );
                },
                child: Text("Done"),
                color: Colors.grey,
                minWidth: 340),
          ],
        ));
  }
}
