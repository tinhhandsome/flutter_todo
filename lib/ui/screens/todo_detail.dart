import 'package:flutter/material.dart';
import 'package:flutter_todo/models/todo.dart';

class TodoDetailScreen extends StatefulWidget {
  static const routeName = "/todo_detail";
  final Todo todo;

  const TodoDetailScreen({
    @required this.todo,
    Key key,
  }) : super(key: key);
  @override
  _TodoDetailScreenState createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        textTheme: TextTheme(title: Theme.of(context).textTheme.title),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete), onPressed: () {})
        ],
      ),
    );
  }
}
