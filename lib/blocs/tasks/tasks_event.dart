import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class TasksEvent extends Equatable {
  const TasksEvent();
  @override
  List<Object> get props => [];
}

class TasksLoadAllTodoEvent extends TasksEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "TasksLoadAllTodoEvent";
}
