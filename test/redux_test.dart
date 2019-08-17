import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Todo todo;
  AppState appState;

  setUp(() {
    appState = AppState.initial();
    todo = Todo('Do push up');
  });

  test('initial state', () {
    expect(appState.todos, []);
  });

  test('adding todo', () {
    AppState result = appReducer(appState, AddTodo(todo));

    expect(result.todos[0].isCompleted, equals(false));
  });

  test('completing todo', () {
    var appState = AppState(BuiltList.from([todo]));

    AppState result = appReducer(appState, CompleteTodo(todo));

    expect(result.todos[0].isCompleted, equals(true));
  });

  test('reopening todo', () {
    todo = Todo('_', true);
    var appState = AppState(BuiltList.from([todo]));

    AppState result = appReducer(appState, ReopenTodo(todo));

    expect(result.todos[0].isCompleted, equals(false));
  });

  test('deleting todo', () {
    var appState = AppState(BuiltList.from([todo]));

    AppState result = appReducer(appState, DeleteTodo(todo));

    expect(result.todos, equals([]));
  });

  test('editing todo', () {
    var appState = AppState(BuiltList.from([todo]));

    var newTodo = Todo('Do sit up');
    AppState result = appReducer(appState, EditTodo(todo, newTodo));

    expect(result.todos[0], equals(newTodo));
  });
}

class EditTodo {
  Todo todo;
  Todo newTodo;

  EditTodo(this.todo, this.newTodo);
}

@immutable
class Todo {
  final String name;
  final bool isCompleted;

  Todo(this.name, [this.isCompleted = false]);

  @override
  String toString() {
    return name;
  }
}

class DeleteTodo {
  Todo todo;

  DeleteTodo(this.todo);
}

class ReopenTodo {
  Todo todo;

  ReopenTodo(this.todo);
}

class CompleteTodo {
  Todo todo;

  CompleteTodo(this.todo);
}

class AddTodo {
  Todo todo;

  AddTodo(this.todo);
}

AppState appReducer(AppState appState, action) {
  if (action is AddTodo) {
    return AppState(BuiltList.of(appState.todos.toList()..add(action.todo)));
  } else if (action is CompleteTodo) {
    return AppState(BuiltList.of(appState.todos
        .map((todo) => todo == action.todo ? Todo(todo.name, true) : todo)));
  } else if (action is ReopenTodo) {
    return AppState(BuiltList.of(appState.todos
        .map((todo) => todo == action.todo ? Todo(todo.name, false) : todo)));
  } else if (action is DeleteTodo) {
    return AppState(BuiltList.of(
        appState.todos.toList()..removeWhere((todo) => todo == action.todo)));
  } else if (action is EditTodo) {
    return AppState(BuiltList.of(appState.todos
        .toList()
        .map((todo) => todo == action.todo ? action.newTodo : todo)));
  }
  return appState;
}

@immutable
class AppState {
  final BuiltList<Todo> todos;

  factory AppState.initial() {
    return AppState(BuiltList.of([]));
  }

  AppState(this.todos);
}
