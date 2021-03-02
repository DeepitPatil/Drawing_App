import 'package:flutter/cupertino.dart';

class Drawing {
  int ID;
  String name;
  bool visibility = true;
  List<Offset> points = <Offset>[];

  Drawing(this.ID, this.name);
}