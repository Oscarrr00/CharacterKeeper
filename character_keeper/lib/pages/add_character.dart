import 'package:character_keeper/items/character_general.dart';
import 'package:character_keeper/pages/characters_page.dart';
import 'package:flutter/material.dart';

class AddCharacterPage extends StatelessWidget {
  const AddCharacterPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Create Character"),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CharactersUser(),
                    ),
                  );
                },
                icon: Icon(Icons.account_circle_rounded))
          ],
        )),
        body: Column(
          children: [
            TextField(
              controller: nameController,
            )
          ],
        ));
  }
}
