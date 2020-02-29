import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_todo/blocs/todo/todo_bloc.dart';
import 'package:flutter_todo/blocs/todo/todo_event.dart';
import 'package:flutter_todo/blocs/todo/todo_state.dart';
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
          IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: () {
                BlocProvider.of<TodoBloc>(context)
                    .add(TodoDeleteEvent(widget.todo));
              })
        ],
      ),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoUpdatedState) {
            Navigator.of(context).pop();
          }
          if (state is TodoDeletedState) {
            Navigator.of(context).pop();
          }
        },
        child: StreamBuilder<Todo>(
            stream: _todoSubject,
            initialData: Todo.fromJson(widget.todo.toJson()),
            builder: (context, snapshot) {
              var todo = snapshot.data;
              if (snapshot.data.expired != null && snapshot.data.expired > 0) {
                date =
                    DateTime.fromMillisecondsSinceEpoch(snapshot.data.expired);
              }
              var time = Formatter.formatDateNotAgoFrom(snapshot.data.expired);
              return ListView(
                children: <Widget>[
                  ListTile(
                    leading: CircularCheckBox(
                        value: todo.done,
                        activeColor: Theme.of(context).primaryColor,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        onChanged: (bool value) {
                          todo.done = value;
                          BlocProvider.of<TodoBloc>(context)
                              .add(TodoUpdateEvent(todo));
                        }),
                    title: const Text("Done"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'Title',
                          ),
                          style: Theme.of(context).textTheme.title.copyWith(
                              decoration: todo.done
                                  ? TextDecoration.lineThrough
                                  : null),
                          autofocus: true,
                          controller: _titleController,
                          enabled: !todo.done,
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
                          enabled: !todo.done,
                          onChanged: (value) {
                            todo.description = value;
                            _todoSubject.add(todo);
                          },
                        ),
                        time.isEmpty && todo.done
                            ? Container()
                            : FlatButton(
                                padding: EdgeInsets.zero,
                                onPressed: todo.done
                                    ? null
                                    : () {
                                        DatePicker.showDateTimePicker(
                                          context,
                                          showTitleActions: true,
                                          minTime: DateTime(2018, 3, 5),
                                          maxTime: DateTime.now()
                                              .add(const Duration(days: 365)),
                                          onChanged: (date) {},
                                          onConfirm: (pick) {
                                            date = pick;
                                            todo.expired =
                                                pick.millisecondsSinceEpoch;
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
                                        child: Text(time.isNotEmpty
                                            ? time
                                            : "Add time")),
                                    time.isNotEmpty && !todo.done
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
                        const SizedBox(height: 10,),
                        todo.done
                            ? Container()
                            : Center(
                                child: MaterialButton(
                                  elevation: 0,
                                    color: Theme.of(context).primaryColor,
                                    child: Text(
                                      "Save",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<TodoBloc>(context)
                                          .add(TodoUpdateEvent(todo));
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0))),
//                                child: Container(
//                                  decoration: BoxDecoration(
//                                      borderRadius: BorderRadius.circular(50),
//                                      border: Border.all(
//                                          color:
//                                              Theme.of(context).dividerColor)),
//                                  child: FlatButton(
//                                    padding: EdgeInsets.zero,
//                                    onPressed: () {
//                                      BlocProvider.of<TodoBloc>(context)
//                                          .add(TodoUpdateEvent(todo));
//                                    },
//                                    child: Text(
//                                      "Save",
//                                      style: TextStyle(
//                                          color:
//                                              Theme.of(context).primaryColor),
//                                    ),
//                                  ),
//                                ),
                              ),
                      ],
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _todoSubject.close();
  }
}
