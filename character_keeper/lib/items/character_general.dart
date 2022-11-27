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
          height: MediaQuery.of(context).size.height / 7,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey,
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text("${character.name}",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text("${character.race} ${character.character_class}"),
              Text("Lvl ${character.level}"),
            ],
          ),
        ),
      ),
    );
  }
}
