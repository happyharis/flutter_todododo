import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditTodoPage extends StatefulWidget{
  final String value;

  EditTodoPage({Key key, this.value}) : super (key: key);
  // Optional parameters, global key, 
  
  @override
  EditTodoPageState createState() => new EditTodoPageState();
}

class EditTodoPageState extends State<EditTodoPage> {
  final DocumentReference documentReference = Firestore.instance.collection('todo_list').document();
  
  void _update() {
    Map<String, String> data = <String, String> {

    };
    documentReference.updateData(data).whenComplete((){

    });
  }
}