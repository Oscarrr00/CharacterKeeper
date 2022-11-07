import 'package:flutter/material.dart';

class DataDeIncrementSmaller extends StatelessWidget {
  final TextEditingController controller;
  int startingValue;
  DataDeIncrementSmaller({
    Key? key,
    required this.startingValue,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.text = startingValue.toString();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25,
          width: 30,
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
          ),
        ),
        Container(
          height: 25.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 12.5,
                decoration: ShapeDecoration(
                    shape: BeveledRectangleBorder(
                        side: BorderSide(
                  color: Colors.black,
                ))),
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.arrow_drop_up,
                    size: 11.0,
                  ),
                ),
              ),
              Container(
                height: 12.5,
                decoration: ShapeDecoration(
                    shape: BeveledRectangleBorder(
                        side: BorderSide(
                  color: Colors.black,
                ))),
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: 11.0,
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
