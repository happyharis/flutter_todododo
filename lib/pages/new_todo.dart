import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import './landing_page.dart';

class NewTododoPage extends StatefulWidget {
  @override
  State createState() => new NewTododoPageState();
}


class NewTododoPageState extends State<NewTododoPage> {
  final DocumentReference documentReference = Firestore.instance.collection('todo_list').document();
  final _taskController = new TextEditingController();
  List<String> txtList = [];

  DateTime _date = new DateTime.now();

  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: new DateTime(2016),
      lastDate: new DateTime(2019)
    );

    if(picked != null && picked != _date) {
      print('Date selected: ${_date.toString()}');
      
      setState(() {
        _date = picked;
      });
    }
  }

  @override
  void initState(){
    super.initState();
    initializeDateFormatting();
    
  }

  @override
  void dispose() {
    _taskController.dispose();
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
              title: new Text( DateFormat('d MMMM y', 'en').format(_date)),
              onTap: () => _selectedDate(context),
            ),
            new Padding(padding: const EdgeInsets.all(15.0),),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new RaisedButton(  
                  child: new Text("Save"),
                  onPressed: (){
                    txtList.add(_taskController.text);
                    Firestore.instance.collection('todo_list').document()
                    .setData({ 'task': _taskController.text, 'due_date': _date.toString() });
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
