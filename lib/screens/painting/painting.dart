import 'package:flutter/material.dart';
import 'package:drawing_app/screens/home/home.dart';

class Painting extends StatefulWidget {
  static int id;

  Painting(int ID){
    id = ID;
  }

  @override
  _PaintingState createState() => _PaintingState();
}

class _PaintingState extends State<Painting> {
  List<Offset> _points = Home.drawings[Home.fetchDrawingIndexByID(Painting.id)].points;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      /*appBar: AppBar(
        title: Text(Home.drawings[Home.fetchDrawingIndexByID(Painting.id)].name),
      ),*/
      body: new Container(
        child: new GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              RenderBox object = context.findRenderObject();
              Offset _localPosition =
              object.globalToLocal(details.globalPosition);
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
      /*floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.clear),
        onPressed: () => _points.clear(),
      ),*/
        floatingActionButton: Padding(padding: EdgeInsets.all(20.0),child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                child: new Icon(Icons.save),
                backgroundColor: Colors.green,
                onPressed: () => saveDrawing(_points),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
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
      ..color = Colors.blue
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
