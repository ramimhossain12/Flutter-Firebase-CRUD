import 'package:flutter/material.dart';

class SingleTodo extends StatelessWidget {
  final String todo;
  final String id;
  final Function editFuction;
  final Function deletefunction;

  SingleTodo({required this.todo, required this.id, required this.deletefunction,required this.editFuction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                todo,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    editFuction();
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.green,
                  )),
              IconButton(
                  onPressed: () {
                    deletefunction(id);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.deepOrange,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
