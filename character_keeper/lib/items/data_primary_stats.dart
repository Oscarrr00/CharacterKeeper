import 'package:flutter/material.dart';

class DataPrimaryStats extends StatelessWidget {
  final String stat;
  final int stat_modifier;
  final int stat_number;
  DataPrimaryStats({
    Key? key,
    required this.stat,
    required this.stat_modifier,
    required this.stat_number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShapeDecoration decoration_border = new ShapeDecoration(
        shape: BeveledRectangleBorder(
            side: BorderSide(
      color: Colors.black,
    )));
    return Container(
        width: 310 / 3,
        height: 250 / 2,
        child: Column(children: [
          Text("${stat}", style: TextStyle(fontSize: 18)),
          Expanded(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.black,
              ),
              SizedBox(width: 15),
              Text("+${stat_modifier}", style: TextStyle(fontSize: 18)),
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
