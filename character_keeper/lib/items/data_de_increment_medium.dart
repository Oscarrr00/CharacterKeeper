import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataDeIncrementMedium extends StatelessWidget {
  final TextEditingController controller;
  int startingValue;
  int index;
  DataDeIncrementMedium({
    Key? key,
    required this.startingValue,
    required this.controller,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.text = startingValue.toString();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 35,
          width: 40,
          child: TextFormField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0),
              border: OutlineInputBorder(),
            ),
            controller: controller,
            keyboardType: TextInputType.numberWithOptions(
              decimal: false,
            ),
            onFieldSubmitted: (value) async {
              var num = int.parse(value);
              await context.read<Character_Provide>().updateAmount(index, num);
            },
          ),
        ),
        Container(
          height: 35.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 17.5,
                decoration: ShapeDecoration(
                    shape: BeveledRectangleBorder(
                        side: BorderSide(
                  color: Colors.black,
                ))),
                child: InkWell(
                  onTap: () async {
                    var num = int.parse(controller.text);
                    num++;
                    controller.text = num.toString();
                    await context
                        .read<Character_Provide>()
                        .updateAmount(index, num);
                  },
                  child: Icon(
                    Icons.arrow_drop_up,
                    size: 15.0,
                  ),
                ),
              ),
              Container(
                height: 17.5,
                decoration: ShapeDecoration(
                    shape: BeveledRectangleBorder(
                        side: BorderSide(
                  color: Colors.black,
                ))),
                child: InkWell(
                  onTap: () async {
                    var num = int.parse(controller.text);
                    num--;
                    controller.text = num.toString();
                    await context
                        .read<Character_Provide>()
                        .updateAmount(index, num);
                  },
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
