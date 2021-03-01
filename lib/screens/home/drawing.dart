

import 'package:flutter/cupertino.dart';

class Drawing {
  int ID;
  String name;
  List<Offset> points = <Offset>[];

  Drawing(this.ID, this.name);
}