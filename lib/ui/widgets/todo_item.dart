import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/blocs/todo/todo_bloc.dart';
import 'package:flutter_todo/blocs/todo/todo_event.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/sevices/services.dart';
import 'package:flutter_todo/ui/screens/todo_detail.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function(Todo) onChanged;
  final Function onPressed;

  const TodoItem({
    Key key,
    this.todo,
    this.onChanged,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: CircularCheckBox(
              value: todo.done,
              activeColor: Theme.of(context).primaryColor,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              onChanged: (bool value) {
                todo.done = value;
                onChanged(todo);
              }),
          title: Text(todo.title),
          onTap: onPressed,
        ),
        const Divider(
          height: 1,
        )
      ],
    );
  }
}
