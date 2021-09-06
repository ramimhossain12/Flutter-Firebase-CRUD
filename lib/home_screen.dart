import 'package:flutter/material.dart';

import 'single_todo.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> todos = [
      'Test ToDO 1',
      'Test ToDO 2',
      'Test ToDO 3',
      'Test ToDO 4',
      'Test ToDO 5'
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("NOTE APP"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, i) => SingleTodo(todo: todos[i]),
        itemCount: todos.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: (context){
            return AlertDialog(
              title: Text("Add Data"),
            );
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
