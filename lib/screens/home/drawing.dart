import 'package:flutter/cupertino.dart';
import 'dart:convert';

class Drawing {
  int ID;
  String name;
  bool visibility = true;
  List<Offset> points;
  String points_string = "";

  Drawing(this.ID, this.name, this.points);

  static Map<String, dynamic> toMap(Drawing d) {
    if(d == null)
      return null;
    return {
      'id': d.ID,
      'name': d.name,
      'points': d.points_string,
      };
}

  static String encode(List<Drawing> ds) {
    json.encode(
    ds
        .map<Map<String, dynamic>>((d) => Drawing.toMap(d))
        .toList(),
  );}

  static Map<String, dynamic> toMapP(Offset d) {
    if(d == null)
      return null;
    return {
      'x': d.dx,
      'y': d.dy,
    };
  }

  static String encodeP(List<Offset> ds) {
    json.encode(
      ds
          .map<Map<String, dynamic>>((d) => Drawing.toMapP(d))
          .toList(),
    );
  }

 /* static List<Drawing> decode(String ds) =>
      (json.decode(ds) as List<dynamic>)
          .map<Drawing>((item) => Drawing.fromJson(item))
          .toList();*/
}