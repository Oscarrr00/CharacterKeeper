import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataDeIncrementSmaller extends StatelessWidget {
  final TextEditingController controller;
  int startingValue;
  int index;
  DataDeIncrementSmaller({
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
        Container(
          width: 52,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 25,
                width: 30,
                child: TextFormField(
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 14, bottom: 14),
                    border: InputBorder.none,
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
                          .updateSpellslot(index, num);
                    } catch(e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                      Navigator.of(context).pop();
                    }

                  },
                ),
              ),
              Container(
                height: 39.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              .updateSpellslot(index, num);
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
                              .updateSpellslot(index, num);
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
        ),
      ],
    );
  }
}
