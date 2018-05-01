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

      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new Row(
              children: <Widget>[
                new Expanded(child: new TextField(
                  decoration: new InputDecoration.collapsed(hintText: "Write your task here...")
                ),),
                new Checkbox(value: false, onChanged: (bool value){},)
              ],
            )
          ),
          new ListTile(
            // onTap: null,
            title: new Row(
              children: <Widget>[
                new Expanded(child: new Text("Fkin work"),),
                new Checkbox(
                  value: false, // cannot put null. wtf
                  onChanged: (bool value){
                })
              ],
            )
          ),

        ],
      )
    );
  }
}