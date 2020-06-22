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
    this.getProducts();
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

  void reload() {
    this.allProducts.clear();
    this.getProducts();
  }

  void handleClick(String value, BuildContext context) {
    switch (value) {
      case 'Settings':
        //pop up dialog used to modify categorie's data
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  elevation: 16,
                  child: Container(
                    height: 400.0,
                    width: 360.0,
                  ));
            });
        break;
      case 'Reload':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this._catName),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  print("eaz");
                  reload();
                },
                child: Icon(Icons.arrow_drop_down),
              )),
          // 3 Dots menu in appbar
          PopupMenuButton<String>(
            onSelected: (value) {
              handleClick(value, context);
            },
            itemBuilder: (BuildContext context) {
              return {'Settings', 'Reload'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: allProducts.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return productCard(
                allProducts[index].data['name'],
                allProducts[index].data['description'],
                allProducts[index].data['price'],
                allProducts[index].data['quantity']);
          }),
    );
  }
}

Widget productCard(String name, String description, int prix, int quantite) {
  return Card(
    margin: EdgeInsets.only(top: 10.0),
    child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      ListTile(
        title: Text(name),
        trailing: Text(quantite.toString()),
        subtitle: Text(description + "\nPrice : " + prix.toString() + "€"),
        onLongPress: () {},
      )
    ]),
  );
}
