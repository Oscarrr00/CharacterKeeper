import 'package:character_keeper/items/square_stats.dart';
import 'package:flutter/material.dart';

class DetailsCharacter extends StatelessWidget {
  final dynamic character;
  const DetailsCharacter({
    Key? key,
    this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Column(
              children: [
                Text("${character["name"]}"),
                Text(
                    "lvl ${character["level"]}   ${character["race"]}   ${character["class"]}",
                    style: TextStyle(fontSize: 13)),
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.edit))
          ],
        )),
        body: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: 100,
                  height: 100,
                  child: Column(
                    children: [
                      SizedBox(height: 25),
                      Text("${character["armor"]}",
                          style: TextStyle(fontSize: 19)),
                      Text("Armor", style: TextStyle(fontSize: 14)),
                      Text("Class", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  decoration: ShapeDecoration(
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(
                            color: Colors.black,
                          )))),
              SquareData(
                  content: character["dexterity"], name_content: "Initiative"),
              SquareData(content: character["speed"], name_content: "Speed"),
            ],
          ),
          Container(
              width: 110,
              height: 90,
              child: Column(
                children: [
                  SizedBox(height: 25),
                  Text("${character["armor"]}", style: TextStyle(fontSize: 19)),
                  Text("Armor", style: TextStyle(fontSize: 14)),
                  Text("Class", style: TextStyle(fontSize: 14)),
                ],
              ),
              decoration: ShapeDecoration(
                  shape: BeveledRectangleBorder(
                      side: BorderSide(
                color: Colors.black,
              )))),
        ]));
  }
}
