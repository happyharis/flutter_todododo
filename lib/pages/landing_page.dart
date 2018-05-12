import 'package:flutter/material.dart';
import './new_todo.dart';
import './edit_todo.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class LandingPage extends StatefulWidget {
  @override
  State createState() => new _LandingPageState();
}

enum TestEnum {A}
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
        actions: <Widget>[
          new PopupMenuButton(
            itemBuilder: (BuildContext context){
              return <PopupMenuEntry<TestEnum>>[
                new PopupMenuItem(
                  child: new FlatButton(
                    child: new Text("Done-ded tasks"),
                    onPressed: (){},
                  ),
                ),
              ];
            },
          )
        ],
      ),

      floatingActionButton: fab,
      body: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  State createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  String selectedTodoId;
  Map<String, String> currentTodo = <String, String> {"task": "", "due_date": ""};
  final DocumentReference documentReference = Firestore.instance.collection('todo_list').document();
  


  void _delete (id){
    final DocumentReference document = Firestore.instance.collection('todo_list').document(id);
    print(id);
    document.delete().whenComplete((){
      print("Deleted successfullly");
      setState(() {});
    }).catchError((e)=>print(e));
  }
  @override
  Widget build(BuildContext context) {
  
  
  Future _showAlert(data) async{
    return showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Would you like to make changes?', style: new TextStyle(fontSize: 17.0)),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Edit'),
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(builder: (context) => new EditTodoPage(todo: data, todoID: selectedTodoId,)));
              },
            ),
            new FlatButton(
              child: new Text('Delete'),
              onPressed: (){
                _delete(selectedTodoId);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }
  
  return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('todo_list').snapshots,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return new ListTile(
              subtitle: new Text("Due: " + document['due_date'].toString()),
              onLongPress: (){
                currentTodo['task'] = document['task'];
                currentTodo['due_date'] = document['due_date'].toString();
                selectedTodoId = document.documentID;
                _showAlert(currentTodo);
              },
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