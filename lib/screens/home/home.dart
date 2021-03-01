import 'package:drawing_app/screens/home/drawing_button.dart';
import 'package:flutter/material.dart';
import 'package:drawing_app/screens/home/drawing.dart';

class Home extends StatefulWidget {

  static List<Drawing> drawings = [Drawing(0, "Drawing 1"), Drawing(1, "Drawing 2"), Drawing(2, "Drawing 3"), Drawing(3, "Drawing 4")];

  @override
  _HomeState createState() => _HomeState();

  static int fetchDrawingIndexByID(int id){
    for(int i = 0; i < drawings.length; i++){
      if(drawings[i].ID == id)
        return(i);
    }
    return -1;
  }
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drawing App"),
      ),
      body: ListView(
        children: Home.drawings.map((e) => GestureDetector(
            child: DrawingButton(e.name),
            onTap: () => openPainter(context, e.ID),
        )).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("+",
        style: TextStyle(fontSize: 40), textAlign: TextAlign.center,),
        onPressed: () => addNewDrawing(),
      ),
    );
  }
  
  void addNewDrawing() {
    setState(() {
      int maxID = 0;
      if(Home.drawings.isEmpty)
        Home.drawings.add(Drawing(0, "Drawing 1"));
      else {
        for(Drawing d in Home.drawings){
          if(d.ID > maxID)
            maxID = d.ID;
        }
        Home.drawings.add(Drawing(maxID+1, "Drawing "+(maxID+2).toString()));
      }
    });
  }

  void openPainter(BuildContext context, int drawingID) {
    Navigator.pushNamed(context, '/painting', arguments: {"id": drawingID});
  }
}
