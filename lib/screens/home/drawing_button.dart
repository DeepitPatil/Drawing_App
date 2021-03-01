import 'package:flutter/material.dart';

class DrawingButton extends StatelessWidget {
  String _name;

  DrawingButton(this._name);

  @override
  Widget build(BuildContext context) {
    return Card(
        shadowColor: Colors.black,
        margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
        child: ListTile(
          title: Text(_name),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    )
    );
  }
}
