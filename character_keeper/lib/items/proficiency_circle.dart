import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProficiencyCircle extends StatelessWidget {
  double radius;
  int status;
  String stat;

  ProficiencyCircle({
    required this.radius,
    required this.status,
    required this.stat,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.status++;
        if (this.status > 2) {
          status = 0;
        }
        context.read<Character_Provide>().updateSavingThrows(status, stat);
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
