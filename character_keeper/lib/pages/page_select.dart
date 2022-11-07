import 'package:character_keeper/objects/character.dart';
import 'package:character_keeper/pages/ability_and_proficiency_page.dart';
import 'package:character_keeper/pages/details_character.dart';
import 'package:character_keeper/pages/inventory_page.dart';
import 'package:character_keeper/pages/note_page.dart';
import 'package:character_keeper/pages/spell_page.dart';
import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PageSelect extends StatefulWidget {
  

  @override
  State<PageSelect> createState() => _PageSelectState();
}

class _PageSelectState extends State<PageSelect> {
  
  int _selectedIndex = 2;

  
  static List<Widget> _widgetOptions = <Widget>[    
    AbilityAndProficiencyPage(),
    SpellPage(),
    DetailsCharacter(),
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
    Character character = context.watch<Character_Provide>().currentCharacter;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Column(
              children: [
                Text(character.name),
                Text(
                  "Lvl ${character.level} ${character.race} ${character.character_class}",
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


