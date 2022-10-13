import 'package:character_keeper/items/data_de_increment.dart';
import 'package:character_keeper/items/data_hitpoints.dart';
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
    var maxHitpointsController = TextEditingController();
    var currentHitpointsController = TextEditingController();
    var temporaryHitpointsController = TextEditingController();
    var hitDiceController = TextEditingController();
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
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    content: character["dexterity"],
                    name_content: "Initiative"),
                SquareData(content: character["speed"], name_content: "Speed"),
              ],
            ),
            SizedBox(height: 7),
            Row(
              children: [
                DataHitpoints(
                    first_title: "Maximum", controller: maxHitpointsController),
                DataHitpoints(
                    first_title: "Current",
                    controller: currentHitpointsController),
                DataHitpoints(
                    first_title: "Temporary",
                    controller: temporaryHitpointsController),
              ],
            ),
            SizedBox(height: 7),
            Row(
              children: [
                Container(
                    alignment: Alignment.center,
                    height: 42,
                    width: 170,
                    decoration: ShapeDecoration(
                        shape: BeveledRectangleBorder(
                            side: BorderSide(
                      color: Colors.black,
                    ))),
                    child: Text("Hit Dice ", style: TextStyle(fontSize: 14))),
                Container(
                    alignment: Alignment.center,
                    height: 42,
                    width: 100,
                    decoration: ShapeDecoration(
                        shape: BeveledRectangleBorder(
                            side: BorderSide(
                      color: Colors.black,
                    ))),
                    child: DataDeIncrement(controller: hitDiceController)),
                Container(
                    alignment: Alignment.center,
                    height: 42,
                    width: 81,
                    decoration: ShapeDecoration(
                        shape: BeveledRectangleBorder(
                            side: BorderSide(
                      color: Colors.black,
                    ))),
                    child: Text("${character["hitDice"]}")),
              ],
            ),
            SizedBox(height: 7),
          ]),
        ));
  }
}
