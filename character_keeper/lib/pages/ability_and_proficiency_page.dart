import 'package:character_keeper/objects/character.dart';
import 'package:character_keeper/pages/ability_page.dart';
import 'package:character_keeper/pages/proficiency_page.dart';
import 'package:flutter/material.dart';

class AbilityAndProficiencyPage extends StatelessWidget {
  const AbilityAndProficiencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          automaticallyImplyLeading: false,
          title: TabBar(
            indicatorColor: Theme.of(context).colorScheme.primaryContainer,
            labelColor: Theme.of(context).colorScheme.primaryContainer,
            unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
            tabs: [
              Tab(text: "PROFICIENCIES"),
              Tab(text: "ABILITIES"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ProficiencyPage(
              character: Character.fromJson(myCharacter),
            ),
            AbilityPage(),
          ],
        ),
      ),
    );
  }
}
