import 'package:flutter/material.dart';

class DataDeIncrement extends StatelessWidget {
  final TextEditingController controller;
  DataDeIncrement({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          width: 45,
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
          height: 40.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 19.5,
                decoration: ShapeDecoration(
                    shape: BeveledRectangleBorder(
                        side: BorderSide(
                  color: Colors.black,
                ))),
                child: Icon(
                  Icons.arrow_drop_up,
                  size: 18.0,
                ),
              ),
              Container(
                height: 19.5,
                decoration: ShapeDecoration(
                    shape: BeveledRectangleBorder(
                        side: BorderSide(
                  color: Colors.black,
                ))),
                child: Icon(
                  Icons.arrow_drop_down,
                  size: 18.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
