class Todo {
  int id;
  int parentId;
  String title;
  String description;
  bool done;
  String expired;

  Todo({this.id, this.title, this.done, this.description, this.expired});

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    title = json['title'];
    done = json['done'];
    description = json['description'];
    expired = json['expired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['title'] = title;
    data['done'] = done;
    data['description'] = description;
    data['expired'] = expired;
    return data;
  }

  Todo.fromDatabaseJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    title = json['title'];
    done = json['done'] == 1;
    description = json['description'];
    expired = json['expired'];
  }

  Map<String, dynamic> toDatabaseJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['title'] = title;
    data['done'] = done ? 1 : 0;
    data['description'] = description;
    data['expired'] = expired;
    return data;
  }
}
