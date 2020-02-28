import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_todo/models/models.dart';

@immutable
abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TasksLoadingState extends TasksState {}

class TasksInitialState extends TasksState {
  @override
  List<Object> get props => [];
}

class TasksLoadedAllTodoState extends TasksState {
  final Map<AppTabs, List<Todo>> mapTodo;

  const TasksLoadedAllTodoState(this.mapTodo);

  @override
  List<Object> get props => [mapTodo];

  @override
  String toString() => "TasksLoadedAllTodoState {mapTodo: $mapTodo}";
}

class TasksErrorState extends TasksState {
  final String message;

  const TasksErrorState(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => "TasksErrorState {message: $message}";
}
