import 'package:flutter/material.dart';

class SingleTodo extends StatelessWidget {
  final String todo;

  SingleTodo({required this.todo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(todo,style: TextStyle(fontWeight:FontWeight.bold,),),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.edit,color: Colors.green,)),
              IconButton(onPressed: () {}, icon: Icon(Icons.delete,color: Colors.deepOrange,)),
              IconButton(onPressed: () {}, icon: Icon(Icons.delete,color: Colors.deepOrange,)),
              IconButton(onPressed: () {}, icon: Icon(Icons.delete,color: Colors.deepOrange,)),
              IconButton(onPressed: () {}, icon: Icon(Icons.delete,color: Colors.deepOrange,)),
            ],
          ),
        ),
      ),
    );
  }
}
