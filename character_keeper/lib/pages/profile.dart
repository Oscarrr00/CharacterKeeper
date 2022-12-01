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
            title: const Text('Change Username'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                      style: TextStyle(color: Colors.black),
                      controller: usernameController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          hintText: "${profile["username"]}",
                          hintStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black),
                          ))),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Done'),
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
                MaterialButton(
                    onPressed: () {
                      _showDialogUpdateUsername();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: Colors.black)),
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
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.black)),
                minWidth: 300,
                color: Colors.grey),
          ],
        ));
  }
}
