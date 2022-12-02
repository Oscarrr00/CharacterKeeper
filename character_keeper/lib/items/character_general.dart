import 'package:character_keeper/objects/character.dart';
import 'package:character_keeper/pages/details_character.dart';
import 'package:character_keeper/pages/page_select.dart';
import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemCharacter extends StatelessWidget {
  int index;
  ItemCharacter({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(context.watch<Character_Provide>().characterList[index]);
    Character character =
        context.watch<Character_Provide>().characterList[index];
    Future<void> _showDialogDeleteCharacter(int index) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Adding an Item'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Are you sure you want to delete this character?",
                      style: TextStyle(fontSize: 16))
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
                onPressed: () async {
                  await context
                      .read<Character_Provide>()
                      .deleteCharacter(index);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 25.0),
      child: GestureDetector(
        onTap: () async {
          await context.read<Character_Provide>().setCurrentCharacter(index);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PageSelect(),
            ),
          );
        },
        child: Container(
          height: MediaQuery.of(context).size.height / 6.5,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 35),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("${character.name}",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.delete),
                      splashColor: Colors.red[200],
                      onPressed: () async {
                        _showDialogDeleteCharacter(index);
                      })
                ],
              ),
              SizedBox(height: 7),
              Text("${character.race} ${character.character_class}"),
              Text("Lvl ${character.level}"),
            ],
          ),
        ),
      ),
    );
  }
}
