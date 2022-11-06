import 'package:flutter/material.dart';

class ProficiencyCircle extends StatelessWidget {
  double radius; 
  int status;

  ProficiencyCircle({
    required this.radius,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: this.radius + 3,
      backgroundColor: Colors.black,
      child: CircleAvatar(
        backgroundColor: 
          this.status == 2 ? Theme.of(context).colorScheme.primary :
          this.status == 1 ? Colors.black :
          Colors.white,
        
        radius: this.radius,
      ),
    );
  }
}