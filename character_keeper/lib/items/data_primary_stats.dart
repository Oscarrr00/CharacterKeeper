import 'package:character_keeper/items/proficiency_circle.dart';
import 'package:flutter/material.dart';

class DataPrimaryStats extends StatelessWidget {
  final String stat;
  final String stat_modifier;
  final int stat_number;
  final int proficiency;

  DataPrimaryStats({
    Key? key,
    required this.stat,
    required this.stat_modifier,
    required this.stat_number,
    required this.proficiency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShapeDecoration decoration_border = new ShapeDecoration(
        shape: BeveledRectangleBorder(
            side: BorderSide(
      color: Colors.black,
    )));
    return Container(
        width: MediaQuery.of(context).size.height / 8,
        height: MediaQuery.of(context).size.height / 6,
        child: Column(children: [
          Text("${stat}", style: TextStyle(fontSize: 16)),
          Expanded(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ProficiencyCircle(radius: 12, status: this.proficiency),
              SizedBox(width: 15),
              Text("${stat_modifier}", style: TextStyle(fontSize: 18)),
            ]),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child:
                        Text("${stat_number}", style: TextStyle(fontSize: 16)),
                    decoration: decoration_border),
              ),
            ],
          )
        ]),
        decoration: decoration_border);
  }
}
