import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_todo/models/models.dart';

@immutable
abstract class TodoEvent extends Equatable {
  const TodoEvent();
  @override
  List<Object> get props => [];
}

class TodoAddEvent extends TodoEvent {
  final Todo todo;

  const TodoAddEvent(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => "TodoAddEvent {todo: ${todo.toJson()}}";
}

class TodoUpdateEvent extends TodoEvent {
  final Todo todo;

  const TodoUpdateEvent(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => "TodoUpdateEvent {todo: ${todo.toJson()}}";
}

class TodoMarkIncompleteEvent extends TodoEvent {
  final Todo todo;

  const TodoMarkIncompleteEvent(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => "TodoMarkIncompleteEvent {todo: ${todo.toJson()}}";
}

class TodoCompleteEvent extends TodoEvent {
  final Todo todo;

  const TodoCompleteEvent(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => "TodoCompleteEvent {todo: ${todo.toJson()}}";
}

class TodoDeleteEvent extends TodoEvent {
  final Todo todo;

  const TodoDeleteEvent(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => "TodoDeleteEvent {todo: ${todo.toJson()}}";
}
