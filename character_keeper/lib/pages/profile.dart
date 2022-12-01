import 'package:character_keeper/items/show_data.dart';
import 'package:character_keeper/pages/check_auth_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/character_provider.dart';

class Profile extends StatelessWidget {
  final dynamic profile;
  const Profile({
    Key? key,
    this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {},
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
