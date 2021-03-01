import 'package:drawing_app/screens/home/drawing_button.dart';
import 'package:flutter/material.dart';
import 'package:drawing_app/screens/home/drawing.dart';
import 'package:drawing_app/screens/painting/dismissible_widget.dart';
import 'package:drawing_app/screens/home/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {

  static List<Drawing> drawings = [null, Drawing(0, "Drawing 1"), Drawing(1, "Drawing 2"), Drawing(2, "Drawing 3"), Drawing(3, "Drawing 4"), null];

  @override
  _HomeState createState() => _HomeState();

  static int fetchDrawingIndexByID(int id){
    for(int i = 1; i < drawings.length-1; i++){
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
      body: ListView.separated(
        itemCount: Home.drawings.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          if (index == 0 || index == Home.drawings.length-1) {
            return Container(); // zero height: not visible
          }
          final item = Home.drawings[index];

          return DismissibleWidget(
            item: item,
            child: buildListTile(item),
            onDismissed: (direction) =>
                dismissItem(context, index, direction),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () => addNewDrawing(),
      ),
    );
  }

  void dismissItem(
      BuildContext context,
      int index,
      DismissDirection direction,
      ) {
    String s;
    setState(() {
      s = Home.drawings[index].name;
      Home.drawings.removeAt(index);
    });

    switch (direction) {
      case DismissDirection.startToEnd:
        Utils.showSnackBar(context, s+' has been deleted');
        break;
      default:
        break;
    }
  }

  Widget buildListTile(Drawing item) => ListTile(
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    ),
    title: Text(item.name),
    onTap: () => openPainter(context, item.ID),
  );
  
  void addNewDrawing() {
    setState(() {
      int maxID = 0;
      if(Home.drawings.isEmpty)
        Home.drawings.add(Drawing(0, "Drawing 1"));
      else {
        for(Drawing d in Home.drawings){
          if(d == null)
            continue;
          if(d.ID > maxID)
            maxID = d.ID;
        }
        Home.drawings.insert(Home.drawings.length-1, Drawing(maxID+1, "Drawing "+(maxID+2).toString()));
      }
    });
  }

  void openPainter(BuildContext context, int drawingID) {
    Navigator.pushNamed(context, '/painting', arguments: {"id": drawingID});
  }
}
