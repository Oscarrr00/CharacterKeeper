import 'package:character_keeper/items/character_app_bar.dart';
import 'package:character_keeper/pages/ability_page.dart';
import 'package:character_keeper/pages/details_character.dart';
import 'package:character_keeper/pages/inventory_page.dart';
import 'package:character_keeper/pages/note_page.dart';
import 'package:character_keeper/pages/spell_page.dart';
import 'package:flutter/material.dart';


dynamic characters = [
      {
        "name": "Character #1",
        "race": "Human",
        "class": "Bard",
        "armor": 15,
        "level": 5,
        "dexterity": 2,
        "strength": 2,
        "constitution": 1,
        "intelligence": 0,
        "wisdom": 1,
        "charisma": 1,
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
        "strength": 2,
        "constitution": 1,
        "intelligence": 0,
        "wisdom": 1,
        "charisma": 1,
        "speed": 30,
        "hitDice": "d8"
      }
    ];


class PageSelect extends StatefulWidget {
  const PageSelect({super.key});

  @override
  State<PageSelect> createState() => _PageSelectState();
}

class _PageSelectState extends State<PageSelect> {
  int _selectedIndex = 2;
  
  static const List<Widget> _widgetOptions = <Widget>[    
    AbilityPage(),
    SpellPage(),
    DetailsCharacter(character: {
        "name": "Character #1",
        "race": "Human",
        "class": "Bard",
        "armor": 15,
        "level": 5,
        "dexterity": 2,
        "strength": 2,
        "constitution": 1,
        "intelligence": 0,
        "wisdom": 1,
        "charisma": 1,
        "speed": 30,
        "hitDice": "d8"
      },),
    InventoryPage(),
    NotePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
                Text("My character #1"),
                Text(
                  "Lvl 5 Human Bard",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                )
              ],
            ),
            SizedBox(width: 40),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.handyman_rounded),
            label: 'Abilities',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Spells',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Character',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.backpack),
            label: 'Inventory',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_present_rounded),
            label: 'Notes',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}


