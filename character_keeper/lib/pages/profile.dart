import 'package:character_keeper/items/show_data.dart';
import 'package:character_keeper/pages/check_auth_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/character_provider.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic profile = context.watch<Character_Provide>().profile;
    var usernameController = TextEditingController();
    Future<void> _showDialogUpdateUsername() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: const Text('Change Username'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "${profile["username"]}",
                      )),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Done',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer)),
                onPressed: () {
                  context
                      .read<Character_Provide>()
                      .updateUsername(usernameController.text);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Your Profile"),
        ),
        body: Column(
          children: [
            SizedBox(height: 50),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Container(
                  width: MediaQuery.of(context).size.width / 5,
                  child: Text("Username")),
              Column(children: [
                ShowData(content: "${profile["username"]}"),
                SizedBox(height: 10),
                MaterialButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      _showDialogUpdateUsername();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text("Change Username"),
                    minWidth: 250)
              ])
            ]),
            SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Container(
                  width: MediaQuery.of(context).size.width / 5,
                  child: Text("Email")),
              Column(children: [
                ShowData(content: "${profile["email"]}"),
              ])
            ]),
            SizedBox(height: 80),
            MaterialButton(
                onPressed: () {
                  context.read<Character_Provide>().logoutUser();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CheckAuthPage(),
                    ),
                  );
                },
                child: Text("Logout"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                minWidth: 300,
                color: Theme.of(context).colorScheme.primary),
          ],
        ));
  }
}
