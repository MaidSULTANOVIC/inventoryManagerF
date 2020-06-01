import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_manager_f/views/CatModification.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'Inventory Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _firestore = Firestore.instance;
  int _counter = 0;
  String catName = "";
  int nbElementCat = -1;

  void _longPress() {
    setState(() {
      print("oui");
    });
  }

  void getProductCat() async {
    await for (var snapshot in _firestore.collection("categorie").snapshots()) {
      for (var categorie in snapshot.documents) {
        String name = categorie.data['name'];
        CatModification $name = new CatModification(categorie.documentID);
        print($name.getId());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getProductCat();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection("categorie").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final categories = snapshot.data.documents;
                    List<CatCard> catWidgets = [];

                    for (var categorie in categories) {
                      final name = categorie.data['name'];
                      final description = categorie.data['description'];

                      //final catWidget = CatCard()
                      return Text(name);
                    }
                  }
                }),
            IconButton(
              icon: Icon(Icons.airplay),
              color: Colors.red,
              onPressed: () {
                _firestore.collection("product").add({
                  'description': 'Pistolezaet a bille',
                  'name': 'Piezastolet',
                  'price': 10,
                  'quantity': 120
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CatCard extends StatefulWidget {
  CatCard({
    Key key,
    String name,
    String description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ListTile(
          title: Text(""),
          trailing: Text("3659"),
          subtitle: Text('Voiture de plusieurs couleur et de different modèle'),
          onLongPress: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => CatModification()),
            // );
          },
        )
      ]),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
