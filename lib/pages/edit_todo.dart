import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './landing_page.dart';

class EditTodoPage extends StatefulWidget{
  final Map<String, String> todo;
  final String todoID;

  EditTodoPage({Key key, this.todo, this.todoID}) : super (key: key);
  // Optional parameters, global key, 
  
  @override
  EditTodoPageState createState() => new EditTodoPageState();
}

class EditTodoPageState extends State<EditTodoPage> {
  
  String selectedTodoId;
  DocumentReference documentReference = Firestore.instance.collection('todo_list').document();
  final _taskController = new TextEditingController();
  final _dueDateController = new TextEditingController();
  
  @override
  void initState(){
    _taskController.text = widget.todo['task'];
    _dueDateController.text = widget.todo['due_date'];
    selectedTodoId = widget.todoID;
    documentReference = Firestore.instance.collection('todo_list').document(selectedTodoId);
    super.initState();
  }
  
  void _update(data) {
    documentReference.updateData(data).whenComplete((){
      print('Document Updated');
    }).catchError((e)=>print(e));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edit To-do Do", style: new TextStyle(fontFamily: "Ubuntu"))
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
            new TextField(
              controller: _dueDateController,
              decoration: new InputDecoration(hintText: "Choose the task's date due "),
            ),
            new Padding(padding: const EdgeInsets.all(15.0),),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new RaisedButton(  
                  child: new Text("Save Changes"),
                  onPressed: (){
                    widget.todo["task"] = _taskController.text;
                    widget.todo["due_date"] = _dueDateController.text;
                    _update(widget.todo);
                    Navigator.popUntil(context, (route){
                      return route.settings.name == "/";
                    });
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