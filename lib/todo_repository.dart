import 'package:flutter/material.dart';
import 'package:flutter_todo_redux/local_json_storage.dart';
import 'package:flutter_todo_redux/todo.dart';

@immutable
class TodoRepository {
  final LocalJsonStorage localJsonStorage;
  final filename = 'todos.json';

  TodoRepository(this.localJsonStorage);

  void saveTodos(List<Todo> todos) {
    localJsonStorage.saveJson(filename, todos);
  }

  Future<List<Todo>> loadTodos() async {
    var json = await localJsonStorage.getJson(filename);
    if (json != null) {
      return (json as List).map((e) => Todo.fromJson(e)).toList();
    }
    return [];
  }
}
