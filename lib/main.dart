import 'package:flutter/material.dart';

import './pages/landing_page.dart';
import './pages/edit_todo.dart';
import './pages/new_todo.dart';


void main() {
  runApp(Tododo());
}

class Tododo extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LandingPage(),
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => new LandingPage()
      },
    );
  }
}