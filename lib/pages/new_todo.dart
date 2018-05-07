import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './landing_page.dart';

class NewTododoPage extends StatefulWidget {
  @override
  State createState() => new NewTododoPageState();
}


class NewTododoPageState extends State<NewTododoPage> {
  final DocumentReference documentReference = Firestore.instance.collection('todo_list').document();
  final _taskController = new TextEditingController();
  final _dueDateController = new TextEditingController();
  List<String> txtList = [];

  @override
  void dispose() {
    _taskController.dispose();
    _dueDateController.dispose();
    super.dispose();
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
              controller: _taskController,
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
            new ListTile(
              leading: new Icon(Icons.today, color: Colors.grey[500],),
            ),
            new Padding(padding: const EdgeInsets.all(15.0),),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new RaisedButton(  
                  child: new Text("Save"),
                  onPressed: (){
                    txtList.add(_taskController.text);
                    txtList.add(_dueDateController.text);
                    Firestore.instance.collection('todo_list').document()
                    .setData({ 'task': _taskController.text, 'due_date': _dueDateController.text });
                    Navigator.of(context).pop(new MaterialPageRoute(builder: (BuildContext context) => new LandingPage()));
                    print(txtList);
                  },
                )
              ],
            ),
          ]
        ),
      ),
    );
  }
}

