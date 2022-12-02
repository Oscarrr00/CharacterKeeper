import 'package:character_keeper/items/character_general.dart';
import 'package:character_keeper/pages/profile.dart';
import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharactersUser extends StatelessWidget {
  const CharactersUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic characterName = TextEditingController();
    dynamic characterLevel = TextEditingController();
    dynamic characterClass = TextEditingController();
    dynamic characterRace = TextEditingController();

    Future<void> _showDialogAddCharacter() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Create a new character'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                      controller: characterName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Your character's name",
                      )),
                  SizedBox(height: 20),
                  TextField(
                      controller: characterClass,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Your character's class",
                      )),
                  SizedBox(height: 20),
                  TextField(
                      controller: characterRace,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Your character's race",
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Text("Character Level   ",
                            style: Theme.of(context).textTheme.headline3),
                        SizedBox(
                          height: 25,
                          width: 30,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8.0),
                              border: OutlineInputBorder(),
                            ),
                            controller: characterLevel,
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  characterName.text = "";
                  characterClass.text = "";
                  characterLevel.text = "";
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Done'),
                onPressed: () {
                  int n;
                  try {
                    n = int.parse(characterLevel.text);
                  } catch (e) {
                    n = 1;
                  }

                  try {
                    context.read<Character_Provide>().addCharacter(
                        characterName.text,
                        characterClass.text,
                        n,
                        characterRace.text);
                    characterName.text = "";
                    characterClass.text = "";
                    characterLevel.text = "";
                    characterRace.text = "";
                    Navigator.of(context).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
      );
    }

    List characters = context.watch<Character_Provide>().characterList;
    print(characters);
    return Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Your Characters"),
            IconButton(
                onPressed: () async {
                  await context.read<Character_Provide>().getProfile();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ),
                  );
                },
                icon: Icon(Icons.account_circle_rounded))
          ],
        )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.3,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: characters.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemCharacter(
                      index: index,
                    );
                  },
                ),
              ),
              FloatingActionButton(
                  child: Icon(Icons.add),
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  onPressed: (() {
                    _showDialogAddCharacter();
                  }))
            ],
          ),
        ));
  }
}
