import 'package:flutter/material.dart';

import './pages/landing_page.dart';

void main() {
  runApp(Tododo());
}

class Tododo extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData.light(),
      home: LandingPage(),
    );
  }
}