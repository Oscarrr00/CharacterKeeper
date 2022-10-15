import 'package:character_keeper/items/data_de_increment.dart';
import 'package:character_keeper/items/data_hitpoints.dart';
import 'package:character_keeper/items/data_primary_stats.dart';
import 'package:character_keeper/items/square_stats.dart';
import 'package:character_keeper/pages/ability_page.dart';
import 'package:character_keeper/pages/inventory_page.dart';
import 'package:character_keeper/pages/note_page.dart';
import 'package:character_keeper/pages/proficiency_page.dart';
import 'package:character_keeper/pages/spell_page.dart';
import 'package:flutter/material.dart';

class DetailsCharacter extends StatelessWidget {
  final dynamic character;
  const DetailsCharacter({
    Key? key,
    this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShapeDecoration decoration_border = new ShapeDecoration(
        shape: BeveledRectangleBorder(
            side: BorderSide(
      color: Colors.black,
    )));
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
        body: SingleChildScrollView(
          child: Padding(
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
              SizedBox(height: 10),
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
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: 42,
                      width: 170,
                      decoration: decoration_border,
                      child: Text("Hit Dice ", style: TextStyle(fontSize: 14))),
                  Container(
                      alignment: Alignment.center,
                      height: 42,
                      width: 100,
                      decoration: decoration_border,
                      child: DataDeIncrement(controller: hitDiceController)),
                  Container(
                      alignment: Alignment.center,
                      height: 42,
                      width: 81,
                      decoration: decoration_border,
                      child: Text("${character["hitDice"]}")),
                ],
              ),
              SizedBox(height: 10),
              Container(
                  width: 351,
                  height: 280,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DataPrimaryStats(
                              stat: "Strength",
                              stat_modifier: character["strength"],
                              stat_number: 14),
                          DataPrimaryStats(
                              stat: "Dexterity",
                              stat_modifier: character["dexterity"],
                              stat_number: 14),
                          DataPrimaryStats(
                              stat: "Constitution",
                              stat_modifier: character["constitution"],
                              stat_number: 12),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DataPrimaryStats(
                              stat: "Intelligence",
                              stat_modifier: character["intelligence"],
                              stat_number: 10),
                          DataPrimaryStats(
                              stat: "Wisdom",
                              stat_modifier: character["wisdom"],
                              stat_number: 12),
                          DataPrimaryStats(
                              stat: "Charisma",
                              stat_modifier: character["charisma"],
                              stat_number: 12),
                        ],
                      )
                    ],
                  ),
                  decoration: decoration_border),
        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProficiencyPage()));
                    }, child: Text("Proficiencies")),
        
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AbilityPage()));
                      }, child: Text("Abilities")),
                    ),
        
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SpellPage()));
                    }, child: Text("Spells")),
                  ],),
        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NotePage()));
                    }, child: Text("Notes")),
        
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InventoryPage()));
                    }, child: Text("Inventory")),
        
                    
                  ],)
            ]),
          ),
        ));
  }
}
