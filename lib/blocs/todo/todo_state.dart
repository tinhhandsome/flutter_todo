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

class TodoLoadingState extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoAddedState extends TodoState {
  final Todo todo;

  const TodoAddedState(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => "TodoAddedState {todo: ${todo.toJson()}}";
}

class TodoUpdatedState extends TodoState {
  final Todo todo;

  const TodoUpdatedState(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => "TodoUpdatedState {todo: ${todo.toJson()}}";
}

class TodoDeletedState extends TodoState {
  final Todo todo;

  const TodoDeletedState(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => "TodoDeletedState {todo: ${todo.toJson()}}";
}

class TodoErrorState extends TodoState {
  final String message;

  const TodoErrorState(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => "TodoErrorState {message: $message}";
}

class TodoLoadedAllState extends TodoState {
  @override
  List<Object> get props => [];

  @override
  String toString() => "TodoLoadedAllState";
}
