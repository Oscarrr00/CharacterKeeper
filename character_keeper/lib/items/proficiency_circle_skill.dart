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
      onTap: () async {
        if (this.status == 1)
          await context
              .read<Character_Provide>()
              .updateProficiency(this.index, 0);
        if (this.status == 0)
          await context
              .read<Character_Provide>()
              .updateProficiency(this.index, 1);
      },
      child: CircleAvatar(
        radius: this.radius + 3,
        backgroundColor: Colors.black,
        child: CircleAvatar(
          backgroundColor: this.status == 2
              ? Theme.of(context).colorScheme.primary
              : this.status == 1
                  ? Colors.black
                  : Colors.white,
          radius: this.radius,
        ),
      ),
    );
  }
}
