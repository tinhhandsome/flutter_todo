import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_todo/models/models.dart';

@immutable
abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitialState extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoLoadingState extends TodoState {}

class TodoAddedState extends TodoState {
  final Todo todo;

  const TodoAddedState(this.todo);

  @override
  List<Object> get props => [todo.toJson()];

  @override
  String toString() => "TodoAddedState {todo: ${todo.toJson()}}";
}

class TodoUpdatedState extends TodoState {
  final Todo todo;

  const TodoUpdatedState(this.todo);

  @override
  List<Object> get props => [todo.toJson()];

  @override
  String toString() => "TodoUpdatedState {todo: ${todo.toJson()}}";
}

class TodoMarkedIncompleteState extends TodoState {
  final Todo todo;

  const TodoMarkedIncompleteState(this.todo);

  @override
  List<Object> get props => [todo.toJson()];

  @override
  String toString() => "TodoMarkedIncompleteState {todo: ${todo.toJson()}}";
}

class TodoCompletedState extends TodoState {
  final Todo todo;

  const TodoCompletedState(this.todo);

  @override
  List<Object> get props => [todo.toJson()];

  @override
  String toString() => "TodoCompletedState {todo: ${todo.toJson()}}";
}

class TodoDeletedState extends TodoState {
  final Todo todo;

  const TodoDeletedState(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => "TodoDeletedState {success: $todo}";
}

class TodoErrorState extends TodoState {
  final String message;

  const TodoErrorState(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => "TodoErrorState {message: $message}";
}
