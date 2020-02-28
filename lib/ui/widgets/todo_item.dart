import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/blocs/todo/todo_bloc.dart';
import 'package:flutter_todo/blocs/todo/todo_event.dart';
import 'package:flutter_todo/models/models.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function onDone;

  const TodoItem({Key key, this.todo, this.onDone}) : super(key: key);

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
                BlocProvider.of<TodoBloc>(context).add(TodoUpdateEvent(todo));
              }),
          title: Text(todo.title),
        ),
        const Divider(
          height: 1,
        )
      ],
    );
  }
}
