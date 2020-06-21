import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CatModification extends StatelessWidget {
  String _id;
  String _catName;

  final _firestore = Firestore.instance;
  List<DocumentSnapshot> allProducts = [];

  CatModification(String id) {
    this._id = id;
    this.setCatName();
  }

  String getId() {
    return this._id;
  }

  String getCatName() {
    return this._catName;
  }

  void setCatName() async {
    await for (var snapshot in _firestore.collection("categorie").snapshots()) {
      for (var cat in snapshot.documents) {
        print("cat / " + cat.documentID.toString());
        print("ID :: " + _id);
        if (cat.documentID.toString() == _id) {
          print("DONE ! ");
          this._catName = cat.data['name'];
        }
      }
    }
  }

  void getProducts() async {
    await for (var snapshot in _firestore.collection("product").snapshots()) {
      for (var product in snapshot.documents) {
        String name = product.data['name'];
        if (product.data['categorie'] == _catName) {
          allProducts.add(product);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    this.getProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text(this._catName),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {},
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
