import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CatModification extends StatelessWidget {
  String _id;
  CatModification(String id) {
    this._id = id;
  }

  String getId() {
    return this._id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
