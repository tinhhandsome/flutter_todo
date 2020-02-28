import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_todo/models/todo.dart';
import 'package:flutter_todo/utils/formatter.dart';
import 'package:rxdart/rxdart.dart';

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
  TextEditingController _titleController;
  TextEditingController _descriptionController;

  final BehaviorSubject<Todo> _todoSubject = BehaviorSubject<Todo>();
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo.title);
    _descriptionController =
        TextEditingController(text: widget.todo.description);
  }

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
      body: StreamBuilder<Todo>(
          stream: _todoSubject,
          initialData: Todo.fromJson(widget.todo.toJson()),
          builder: (context, snapshot) {
            var todo = snapshot.data;
            var time = Formatter.formatDateNotAgoFrom(snapshot.data.expired);
            return ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Title',
                        ),
                        autofocus: true,
                        controller: _titleController,
                        onChanged: (value) {
                          todo.title = value;
                          _todoSubject.add(todo);
                        },
                      ),
                      TextField(
                        decoration:
                            const InputDecoration(hintText: 'Description'),
                        autofocus: true,
                        controller: _descriptionController,
                        onChanged: (value) {
                          todo.description = value;
                          _todoSubject.add(todo);
                        },
                      ),
                      FlatButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          DatePicker.showDateTimePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(2018, 3, 5),
                            maxTime:
                                DateTime.now().add(const Duration(days: 365)),
                            onChanged: (date) {},
                            onConfirm: (pick) {
                              date = pick;
                              todo.expired = pick.millisecondsSinceEpoch;
                              _todoSubject.add(todo);
                            },
                            currentTime: date,
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.calendar_today,
                                color: Theme.of(context).primaryColor),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child:
                                    Text(time.isNotEmpty ? time : "Add date")),
                            time.isNotEmpty
                                ? IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      todo.expired = null;
                                      _todoSubject.add(todo);
                                    })
                                : Container()
                          ],
                        ),
                      ),
                      Center(
                        child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _todoSubject.close();
  }
}
