import 'package:character_keeper/items/character_general.dart';
import 'package:character_keeper/pages/profile.dart';
import 'package:flutter/material.dart';

class CharactersUser extends StatelessWidget {
  const CharactersUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic profile = {
      "username": "Masterzombie",
      "email": "Masterzombie@gmail.com",
    };
    dynamic characters = [
      {
        "name": "Character #1",
        "race": "Human",
        "class": "Bard",
        "armor": 15,
        "level": 5,
        "dexterity": 2,
        "speed": 30,
        "hitDice": "d8"
      },
      {
        "name": "Character #2",
        "race": "Human",
        "class": "Bard",
        "armor": 15,
        "level": 5,
        "dexterity": 2,
        "speed": 30,
        "hitDice": "d8"
      }
    ];
    return Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Your Characters"),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Profile(profile: profile),
                    ),
                  );
                },
                icon: Icon(Icons.account_circle_rounded))
          ],
        )),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.3,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: characters.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemCharacter(character: characters[index]);
                },
              ),
            ),
            IconButton(
                iconSize: 64,
                splashRadius: 36,
                onPressed: () {},
                icon: Icon(Icons.add_circle_outline))
          ],
        ));
  }
}
