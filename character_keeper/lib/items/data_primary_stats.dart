import 'package:character_keeper/items/proficiency_circle.dart';
import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataPrimaryStats extends StatelessWidget {
  final String stat;
  final String stat_modifier;
  final int proficiency;
  final TextEditingController controller;

  DataPrimaryStats({
    Key? key,
    required this.stat,
    required this.stat_modifier,
    required this.proficiency,
    required this.controller,
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
              ProficiencyCircle(
                  radius: 12, status: this.proficiency, stat: stat),
              SizedBox(width: 15),
              Text("${stat_modifier}", style: TextStyle(fontSize: 18)),
            ]),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 25,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: controller,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: false,
                        ),
                        onFieldSubmitted: (value) {
                          int num = int.parse(value);
                          context
                              .read<Character_Provide>()
                              .updateStatPrimary(num, stat);
                        },
                      ),
                    ),
                    decoration: decoration_border),
              ),
            ],
          )
        ]),
        decoration: decoration_border);
  }
}
