import 'package:drawing_app/screens/painting/painting.dart';
import 'package:flutter/material.dart';
import 'package:drawing_app/screens/home/home.dart';
import 'package:flutter/painting.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _routes(),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      final Map<String, dynamic> arguments = settings.arguments;
      Widget screen;
      switch (settings.name) {
        case '/':
          screen = Home();
          break;
        case '/painting':
          screen = Painting(arguments['id']);
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }
}