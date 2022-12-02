import 'package:character_keeper/items/input_text.dart';
import 'package:character_keeper/pages/characters_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/character_provider.dart';

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
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text("Create a new acount")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              InputText(
                  label: "CHOOSE A USERNAME",
                  hintText: "New username",
                  controller: newUsernameController,
                  color: Colors.black),
              InputText(
                  label: "ENTER AN EMAIL",
                  hintText: "email@email.com",
                  controller: emailController,
                  color: Colors.black),
              SizedBox(height: 10),
              Text(
                "*Choose a password It must be at least 8 characters long",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              InputText(
                  label: "",
                  hintText: "New password",
                  controller: newPasswordController,
                  color: Colors.black),
              InputText(
                  label: "",
                  hintText: "Confirm new password",
                  controller: confirmPasswordController,
                  color: Colors.black),
              SizedBox(height: 20),
              MaterialButton(
                  onPressed: () {
                    context.read<Character_Provide>().createUser(
                        emailController.text,
                        confirmPasswordController.text,
                        newUsernameController.text);
                  },
                  child: Text("Done"),
                  color: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minWidth: 340),
            ],
          ),
        ));
  }
}
