import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/utils/formatter.dart';

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
    String time = Formatter.formatDateFrom(todo.expired);
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
          title: Text(
            todo.title,
            style: Theme.of(context).textTheme.title.copyWith(
                decoration: todo.done ? TextDecoration.lineThrough : null),
          ),
          subtitle: todo.description != null && todo.description.isNotEmpty
              ? Text(todo.description)
              : null,
          trailing: time.isNotEmpty ? Text(time) : null,
          onTap: onPressed,
        ),
        const Divider(
          height: 1,
        )
      ],
    );
  }
}
