import 'package:drawing_app/screens/home/drawing_button.dart';
import 'package:flutter/material.dart';
import 'package:drawing_app/screens/home/drawing.dart';
import 'package:drawing_app/screens/painting/dismissible_widget.dart';
import 'package:drawing_app/screens/home/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Home extends StatefulWidget {

  static List<Drawing> drawings = [null, Drawing(0, "New Drawing", <Offset>[]), null];

  @override
  _HomeState createState() => _HomeState();

  static int fetchDrawingIndexByID(int id){
    for(int i = 1; i < drawings.length-1; i++){
      if(drawings[i].ID == id)
        return(i);
    }
    return -1;
  }

  static saveData() async {
    String text = Drawing.encode(drawings);
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/savedInfo.txt');
    await file.writeAsString(text);
  }
}

class _HomeState extends State<Home> {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drawing App"),
      ),
      body: Column(
        children: [
          TextFormField(
            cursorColor: Colors.black,
            keyboardType: TextInputType.text,
            controller: controller,
            onChanged: (s) => updateSearch(controller.text.toString().toLowerCase()),
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Search"),
          ),
          Expanded(
              child: ListView.separated(
                itemCount: Home.drawings.length,
                separatorBuilder: (context, index) {
                  if(index>0 && index < Home.drawings.length-1 && !Home.drawings[index].visibility)
                    return Container();
                  return Divider();
                },
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
          )
        ],
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

  Widget buildListTile(Drawing item) => Visibility(
      visible: item.visibility,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        title: Text(item.name),
        onTap: () => openPainter(context, item.ID),
      )
  );

  void updateSearch(String s) {
    for(int i = 1; i < Home.drawings.length-1; i++){
      if(Home.drawings[i].name.toLowerCase().contains(s)){
        setState(() {
          Home.drawings[i].visibility = true;
        });
      }
      else {
        setState(() {
          Home.drawings[i].visibility = false;
        });
      }
    }
  }
  
  void addNewDrawing() {
    setState(() {
      int maxID = 0;
      if(Home.drawings.isEmpty)
        Home.drawings.add(Drawing(0, "New Drawing", <Offset>[]));
      else {
        for(Drawing d in Home.drawings){
          if(d == null)
            continue;
          if(d.ID > maxID)
            maxID = d.ID;
        }
        Home.drawings.insert(Home.drawings.length-1, Drawing(maxID+1, "New Drawing "+(maxID+2).toString(), <Offset>[]));
      }
    });
  }

  void openPainter(BuildContext context, int drawingID) {
    Navigator.pushNamed(context, '/painting', arguments: {"id": drawingID});
  }
}
