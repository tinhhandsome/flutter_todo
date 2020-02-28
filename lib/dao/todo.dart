import "dart:async";

import 'package:flutter_todo/database/database.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/sevices/services.dart';

const String invalidArgumentsException = "Invalid arguments";
const String titleIsEmptyException = "Title is empty";

class TodoDao {
  const TodoDao();
  //Adds new Todo records
  Future<int> createTodo({Todo todo}) async {
    if (todo.title == null || todo.title.isEmpty) {
      throw Exception(titleIsEmptyException);
    }
    final result = locator<DatabaseProvider>()
        .database
        .insert(todoTable, todo.toDatabaseJson());
    return result;
  }

  Future<Todo> getTodoById({int id}) async {
    if (id <= 0) {
      throw Exception(invalidArgumentsException);
    }
    List<Map<String, dynamic>> result = await locator<DatabaseProvider>()
        .database
        .query(todoTable, where: "id = ?", whereArgs: ["$id"]);
    final List<Todo> listTodo = result.isNotEmpty
        ? result.map((item) => Todo.fromDatabaseJson(item)).toList()
        : [];
    return listTodo.isNotEmpty ? listTodo[0] : null;
  }

  //Get All Todo items
  //Searches if query string was passed
  Future<List<Todo>> getAllTodo() async {
    List<Map<String, dynamic>> result =
        await locator<DatabaseProvider>().database.query(todoTable);

    final List<Todo> listTodo = result.isNotEmpty
        ? result.map((item) => Todo.fromDatabaseJson(item)).toList()
        : [];
    return listTodo;
  }

  Future<List<Todo>> getAllTodoCompleted() async {
    List<Map<String, dynamic>> result = await locator<DatabaseProvider>()
        .database
        .query(todoTable, where: "done = 1");

    final List<Todo> listTodo = result.isNotEmpty
        ? result.map((item) => Todo.fromDatabaseJson(item)).toList()
        : [];
    return listTodo;
  }

  Future<List<Todo>> getAllTodoInCompleted() async {
    List<Map<String, dynamic>> result = await locator<DatabaseProvider>()
        .database
        .query(todoTable, where: "done = 0");

    final List<Todo> listTodo = result.isNotEmpty
        ? result.map((item) => Todo.fromDatabaseJson(item)).toList()
        : [];
    return listTodo;
  }

  //Update Todo record
  Future<int> updateTodo({Todo todo}) async {
    if (todo == null) {
      throw Exception(invalidArgumentsException);
    }
    if (todo.title == null || todo.title.isEmpty) {
      throw Exception(titleIsEmptyException);
    }
    final result = await locator<DatabaseProvider>().database.update(
        todoTable, todo.toDatabaseJson(),
        where: "id = ?", whereArgs: [todo.id]);

    return result;
  }

  //Delete Todo records
  Future<int> deleteTodo({int id}) async {
    if (id <= 0) {
      throw Exception(invalidArgumentsException);
    }
    final result = await locator<DatabaseProvider>()
        .database
        .delete(todoTable, where: "id = ?", whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllTodo() async {
    final result = await locator<DatabaseProvider>().database.delete(
          todoTable,
        );

    return result;
  }
}
