import 'package:character_keeper/pages/details_character.dart';
import 'package:flutter/material.dart';

class ItemCharacter extends StatelessWidget {
  final Map<String, dynamic> character;
  ItemCharacter({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 25.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailsCharacter(character: character),
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
              Text("${character["name"]}",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text("${character["race"]} ${character["class"]}"),
              Text("Lvl ${character["level"]}"),
            ],
          ),
        ),
      ),
    );
  }
}
