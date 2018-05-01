import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './landing_page.dart';

class NewTododoPage extends StatefulWidget {
  @override
  State createState() => new NewTododoPageState();
}

class NewTododoPageState extends State<NewTododoPage> {
  final TextEditingController _textctrl = new TextEditingController();
  List<String> txtList = [];
  
  @override
    void initState() {
      Firestore.instance.collection('Todo').document()
      .setData({ 'title': 'This better fkin work', 'author': 'Haris' });
      super.initState();
    }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("New To-do Do", style: new TextStyle(fontFamily: "Ubuntu"))
      ),
      body: new Container(
        padding: const EdgeInsets.all(32.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: new Text("What?", style: new TextStyle(fontSize: 20.0),),
            ),
            new TextField(
              controller: _textctrl,
              maxLines: 1,
              maxLength: 30,
              autocorrect: true,
              decoration: new InputDecoration(
                hintText: "Write your task here. Keep it simple"),
            ),
            new Container(
              padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
              child: new Text("When?", style: new TextStyle(fontSize: 20.0),),
            ),
            new TextField(
              decoration: new InputDecoration(hintText: "Choose the task's date due "),
            ),
            new Padding(padding: const EdgeInsets.all(15.0),),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new RaisedButton(  
                  child: new Text("Save"),
                  onPressed: (){
                    txtList.add(_textctrl.text);
                    _textctrl.clear();
                    Navigator.of(context).pop(new MaterialPageRoute(builder: (BuildContext context) => new LandingPage()));
                    print(txtList);
                  },
                )
              ],
            )
          ]
        ),
      ),
    );

  }
}