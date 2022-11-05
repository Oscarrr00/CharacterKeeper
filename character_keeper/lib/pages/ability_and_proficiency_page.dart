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
            title: const TabBar(
              tabs: [
                Tab(text: "Proficiencies"),
                Tab(text: "Abilities"),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              ProficiencyPage(),
              AbilityPage(),
            ],
          ),
        ),
      );
  }
}