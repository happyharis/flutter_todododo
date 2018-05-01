import 'package:flutter/material.dart';
import './new_todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LandingPage extends StatefulWidget {
  @override
  State createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {


  
  @override
  Widget build(BuildContext context) {
    
    Widget fab = new FloatingActionButton(
      child: new Icon(Icons.add),
      onPressed: () {
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new NewTododoPage()));
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("To-do Do", style: new TextStyle(fontFamily: "Ubuntu"),),
      ),
        
      floatingActionButton: fab,
      body: TodoList(),
    );
  }
}

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('todo_list').snapshots,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return new ListTile(
              subtitle: new Text("Due: " + document['due_date']),
              title: new Row(
                children: <Widget>[
                  new Expanded(child: new Text(document['task']),),
                  new Checkbox(
                    value: false, // cannot put null. wtf
                    onChanged: (bool value){
                  })
                ],
              )
            );
          }).toList(),
        );
      },
    );
  }
}