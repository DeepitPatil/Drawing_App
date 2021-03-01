import 'package:drawing_app/screens/home/drawing_button.dart';
import 'package:flutter/material.dart';
import 'package:drawing_app/screens/home/drawing.dart';

class Home extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Home> {
  List<Drawing> drawings = [Drawing(0, "Drawing 1"), Drawing(1, "Drawing 2"), Drawing(2, "Drawing 3"), Drawing(3, "Drawing 4")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drawing App"),
      ),
      body: ListView(
        children: drawings.map((e) => DrawingButton(e.name)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("+",
        style: TextStyle(fontSize: 40),),
        onPressed: () => addNewDrawing(),
      ),
    );
  }
  
  void addNewDrawing() {
    setState(() {
      int maxID = 0;
      if(drawings.isEmpty)
        drawings.add(Drawing(0, "Drawing 1"));
      else {
        for(Drawing d in drawings){
          if(d.ID > maxID)
            maxID = d.ID;
        }
        drawings.add(Drawing(maxID+1, "Drawing "+(maxID+2).toString()));
      }
    });

  }
}
