import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'single_todo.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _textFielt = TextEditingController();
  final _textUpdate = TextEditingController();

  Future<void> _addtodo() async {
    if (_textFielt.text.length <= 0) {
      return;
    }
    final collection = FirebaseFirestore.instance.collection("todo");
    await collection.add({
      "title": _textFielt.text,
    });

    _textFielt.text = '';
    Navigator.of(context).pop();
    print(_textFielt);
  }

  Future<void> delteTodo(String id) async {
    try {
      final collection = FirebaseFirestore.instance.collection("todo").doc(id);
      await collection.delete();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _updateTodo(String id) async {
    try {
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection("todo").doc(id);
      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.get(documentReference);
        transaction.update(documentReference, {
          'title': _textUpdate.text,
        });
        Navigator.of(context).pop();
        _textUpdate.text = '';
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> editButton(String id) async {
    final collection = FirebaseFirestore.instance.collection("todo").doc(id);
    await collection.get().then((value) {
      _textUpdate.text = value.data()!['title'];
    });
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Update Data"),
            content: TextField(
              controller: _textUpdate,
              decoration: InputDecoration(
                hintText: "Update a Todo",
              ),
            ),
            actions: [
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.red,
                child: Text("Cancel"),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _updateTodo(id);
                },
                color: Colors.green,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
                child: Text("Update"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NOTE APP"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("todo").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('No Data Found'),
            );
          }
          return ListView(
            children: snapshot.data!.docs
                .map((todo) => SingleTodo(
                      todo: todo.data().toString(),
                      id: todo.id,
                      deletefunction: delteTodo,
                      editFuction: editButton,
                    ))
                .toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Add Data"),
                  content: TextField(
                    controller: _textFielt,
                    decoration: InputDecoration(
                      hintText: "Add a Todo",
                    ),
                  ),
                  actions: [
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.red,
                      child: Text("Cancel"),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        _addtodo();
                      },
                      color: Colors.green,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      child: Text("Add"),
                    ),
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
