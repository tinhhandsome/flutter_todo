import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/models/models.dart';

void main() {
  group("Todo", () {
    test("toJson", () {
      Todo todo = Todo(
          id: 1,
          title: "Bài tập",
          description: "Bài tập về nhà",
          done: false,
          expired: "");
      expect(todo.toJson(), {
        "id": 1,
        "title": "Bài tập",
        "description": "Bài tập về nhà",
        "done": false,
        "expired": "",
        "parent_id": null,
      });
    });
    test("fromJson", () {
      Todo todo = Todo(id: 1, title: "Bài tập", done: false, expired: "");
      var json = {
        "id": 1,
        "title": "Bài tập",
        "done": false,
        "expired": "",
        "parent_id": null,
      };
      expect(Todo.fromJson(json).toJson(), todo.toJson());
    });
    // If add entry, not test => failed
    test("size of key = 5", () {
      Todo todo = Todo();
      expect(todo.toJson().keys.length, 6);
    });
  });
}
