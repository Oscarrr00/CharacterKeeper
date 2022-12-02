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
    return Container(
      width: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 35,
            width: 40,
            child: TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 10, left: 11),
              ),
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(
                decimal: false,
              ),
              onFieldSubmitted: (value) async {
                var num = int.parse(value);
                await context
                    .read<Character_Provide>()
                    .updateAmount(index, num);
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
                  height: 13,
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
                      color: Theme.of(context).colorScheme.tertiary,
                      Icons.arrow_drop_up,
                      size: 15.0,
                    ),
                  ),
                ),
                Container(
                  height: 13,
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
                      color: Theme.of(context).colorScheme.tertiary,
                      Icons.arrow_drop_down,
                      size: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
