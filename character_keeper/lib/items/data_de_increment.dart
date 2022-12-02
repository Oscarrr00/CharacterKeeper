import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataDeIncrement extends StatelessWidget {
  final TextEditingController controller;
  final String nameValue;
  DataDeIncrement({
    Key? key,
    required this.controller,
    required this.nameValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
            width: 45,
            child: TextFormField(
              cursorWidth: 2,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(top: 8.0, bottom: 6.5, left: 8.0, right: 8),
              ),
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(
                decimal: false,
              ),
              onFieldSubmitted: (value) {
                var num;
                try {
                  num = int.parse(value);
                } catch(e) {
                  num = 0;
                }
                try {
                  context
                      .read<Character_Provide>()
                      .updateHitpoints(nameValue, num);                  
                } catch(e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
            ),
          ),
          Container(
            height: 39.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 16,
                  child: InkWell(
                    onTap: () {
                      var num = int.parse(controller.text);
                      num++;
                      controller.text = num.toString();
                      context
                          .read<Character_Provide>()
                          .updateHitpoints(nameValue, num);
                    },
                    child: Icon(
                      color: Theme.of(context).colorScheme.tertiary,
                      Icons.arrow_drop_up,
                      size: 19.0,
                    ),
                  ),
                ),
                Container(
                  height: 16,
                  child: InkWell(
                    onTap: () {
                      var num = int.parse(controller.text);
                      num--;
                      controller.text = num.toString();
                      context
                          .read<Character_Provide>()
                          .updateHitpoints(nameValue, num);
                    },
                    child: Icon(
                      color: Theme.of(context).colorScheme.tertiary,
                      Icons.arrow_drop_down,
                      size: 19.0,
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
