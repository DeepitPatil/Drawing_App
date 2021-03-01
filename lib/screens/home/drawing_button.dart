import 'package:flutter/material.dart';

class DrawingButton extends StatelessWidget {
  String _name;

  DrawingButton(this._name);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        _name,
        style: TextStyle(
          fontSize: 30
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      decoration: BoxDecoration(
        border: new Border(
            bottom: new BorderSide(
              color: Colors.black,
              width: 2.0,
              style: BorderStyle.solid
          )
        ),
      )
    );
  }
}
