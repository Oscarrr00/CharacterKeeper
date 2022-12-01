import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProficiencyCircleSkill extends StatelessWidget {
  double radius;
  int status;
  int index;

  ProficiencyCircleSkill({
    required this.radius,
    required this.status,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        status++;
        if (status > 2) {
          status = 0;
        }
        context.read<Character_Provide>().updateProficiency(this.index, status);
      },
      child: CircleAvatar(
        radius: this.radius + 3,
        backgroundColor: this.status == 2
            ? Theme.of(context).colorScheme.primary
            : this.status == 1
                ? Color.fromARGB(255, 243, 243, 244)
                : Theme.of(context).colorScheme.background,
      ),
    );
  }
}
