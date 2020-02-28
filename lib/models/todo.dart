class Todo {
  int id;
  String title;
  String description;
  bool done;
  String expired;

  Todo({this.id, this.title, this.done, this.description, this.expired});

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    done = json['done'];
    description = json['description'];
    expired = json['expired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['done'] = done;
    data['description'] = description;
    data['expired'] = expired;
    return data;
  }

  Todo.fromDatabaseJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    done = json['done'] == 1;
    description = json['description'];
    expired = json['expired'];
  }

  Map<String, dynamic> toDatabaseJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['done'] = done == null ? 0 : done ? 1 : 0;
    data['description'] = description;
    data['expired'] = expired;
    return data;
  }
}
