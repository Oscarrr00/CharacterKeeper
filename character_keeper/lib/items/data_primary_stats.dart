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
    return Container(
      width: MediaQuery.of(context).size.width / 3.5,
      height: MediaQuery.of(context).size.height / 6,
      child: Stack(children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(18),
          ),
          width: MediaQuery.of(context).size.width / 3.5,
          height: MediaQuery.of(context).size.height / 7.1,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text("${stat.toUpperCase()}",
                style: Theme.of(context).textTheme.headline3),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ProficiencyCircle(
                  radius: 12, status: this.proficiency, stat: stat),
              SizedBox(width: 7),
              Text("${stat_modifier}", style: TextStyle(fontSize: 27)),
            ]),
          ]),
        ),
        Positioned(
          bottom: 0,
          left: MediaQuery.of(context).size.width / 3.5 / 3.5,
          child: Container(
            width: 51,
            height: 39,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                  color: Theme.of(context).colorScheme.secondary, width: 1.8),
            ),
            child: TextFormField(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 8.0),
              ),
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(
                decimal: false,
              ),
              onFieldSubmitted: (value) {

                int num;
                try {
                  num = int.parse(value);
                } catch(e) {
                  num = 10;
                }

                try {
                  context.read<Character_Provide>().updateStatPrimary(num, stat);
                } catch(e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
            ),
          ),
        )
      ]),
    );
  }
}
