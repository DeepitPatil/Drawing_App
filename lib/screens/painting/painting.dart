import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:drawing_app/screens/home/home.dart';
import 'package:drawing_app/screens/home/drawing.dart';
import 'dart:ui' as ui;

class Painting extends StatefulWidget {
  final Random rd = Random();
  static int id;

  Painting(int ID){
    id = ID;
  }

  @override
  _PaintingState createState() => _PaintingState();
}

class _PaintingState extends State<Painting> {
  ByteData imgBytes;
  List<Offset> _points = Home.drawings[Home.fetchDrawingIndexByID(Painting.id)].points;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: AppBar(
          title: Text(Home.drawings[Home.fetchDrawingIndexByID(Painting.id)].name),
        ),
      ),
      body: new Container(
        child: new GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              RenderBox object = context.findRenderObject();
              Offset _localPosition =
              object.globalToLocal(details.globalPosition);
              _localPosition = _localPosition.translate(0.0, -(AppBar().preferredSize.height));
              _points = new List.from(_points)..add(_localPosition);
            });
          },
          onPanEnd: (DragEndDetails details) => _points.add(null),
          child: new CustomPaint(
            painter: new Signature(points: _points),
            size: Size.infinite,
          ),
        ),
      ),
        floatingActionButton: Padding(padding: EdgeInsets.all(20.0),child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                heroTag: "left",
                child: new Icon(Icons.save),
                backgroundColor: Colors.green,
                onPressed: () => saveDrawing(_points),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: "right",
                child: new Icon(Icons.clear),
                backgroundColor: Colors.red,
                onPressed: () => _points.clear(),
              ),
            ),
          ],
        ),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  saveDrawing(List<Offset> p) {
    TextEditingController customController = TextEditingController(text: Home.drawings[Home.fetchDrawingIndexByID(Painting.id)].name);

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Save Drawing as"),
        content: TextField(
          controller: customController,
        ),
        actions: [Stack(children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: MaterialButton(
              elevation: 5,
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: MaterialButton(
                elevation: 5,
                child: Text("Save"),
                onPressed: () {
                  if(customController.text.toString().isNotEmpty){
                    Home.drawings[Home.fetchDrawingIndexByID(Painting.id)].name = customController.text.toString();
                    Home.drawings[Home.fetchDrawingIndexByID(Painting.id)].points = p;
                    Home.drawings[Home.fetchDrawingIndexByID(Painting.id)].points_string = Drawing.encodeP(Home.drawings[Home.fetchDrawingIndexByID(Painting.id)].points);
                    print(Home.drawings[Home.fetchDrawingIndexByID(Painting.id)].points_string);
                    //Home.saveData();
                    Navigator.of(context).popUntil((route) => false);
                    Navigator.pushNamed(context, '/');
                  }
                }
            )
          )
        ],)]
      );
    });
  }
}

class Signature extends CustomPainter {
  List<Offset> points;

  Signature({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.grey[600]
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;
}
