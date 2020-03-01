import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/utils/utils.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function(Todo) onChanged;
  final Function onPressed;
  final VoidCallback onDatePressed;

  const TodoItem({
    Key key,
    this.todo,
    this.onChanged,
    this.onPressed,
    this.onDatePressed,
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
          subtitle: todo.description == null && time.isEmpty
              ? null
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    todo.description != null && todo.description.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(todo.description),
                          )
                        : const SizedBox(),
                    time.isNotEmpty
                        ? OutlineButton(
                            onPressed: todo.done ? null : onDatePressed,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.calendar_today,
                                  color: todo.expired <=
                                          DateTime.now().millisecondsSinceEpoch
                                      ? Colors.red
                                      : Theme.of(context).primaryColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(time),
                              ],
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
          onTap: onPressed,
        ),
        const Divider(
          height: 1,
        )
      ],
    );
  }
}
