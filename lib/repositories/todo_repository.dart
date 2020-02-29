import 'package:flutter_todo/dao/todo.dart';
import 'package:flutter_todo/models/models.dart';

class TodoRepository {
  final TodoDao todoDao;

  const TodoRepository({this.todoDao = const TodoDao()});

  Future<List<Todo>> getAllTodoCompleted() async {
    return todoDao.getAllTodoCompleted();
  }

  Future<List<Todo>> getAllTodoIncomplete() async {
    return todoDao.getAllTodoIncomplete();
  }

  Future<List<Todo>> getAll() async {
    return todoDao.getAllTodo();
  }

  Future<Todo> getById({int id}) async {
    return todoDao.getTodoById(id: id);
  }

  Future<Todo> createTodo({Todo todo}) async {
    var id = await todoDao.createTodo(todo: todo);
    return getById(id: id);
  }

  Future<Todo> updateTodo({Todo todo}) async {
    var affected = await todoDao.updateTodo(todo: todo);
    if (affected <= 0) {
      throw Exception("Can not update todo");
    }
    return getById(id: todo.id);
  }

  Future<bool> deleteTodo({Todo todo}) async {
    var affected = await todoDao.deleteTodo(id: todo.id);
    if (affected <= 0) {
      throw Exception("Can not update todo");
    }
    return true;
  }
}
