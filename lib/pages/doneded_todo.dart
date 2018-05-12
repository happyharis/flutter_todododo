import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonededTodoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Done-ded Tasks!", style: new TextStyle(fontFamily: "Ubuntu")),
      ),

      body: DonededList(),
    );

  }
}

class DonededList extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('todo_list').where('status', isEqualTo: true).snapshots,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Row(
                children: <Widget>[
                  new Expanded(child: new Text(document['task'], style: new TextStyle(decoration: TextDecoration.lineThrough),),),
                ],
              )
            );
          }).toList(),
        );
      },
    );

    
      
  }
}