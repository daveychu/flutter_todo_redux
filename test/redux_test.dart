import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_redux/app_state.dart';
import 'package:flutter_todo_redux/redux.dart';
import 'package:flutter_todo_redux/todo.dart';

void main() {
  Todo todo;
  AppState appState;

  setUp(() {
    appState = AppState.initial();
    todo = Todo((b) => b..name = 'Do push up');
  });

  test('initial state', () {
    expect(appState.todos, []);
  });

  test('adding todo', () {
    AppState result = appReducer(appState, AddTodo(todo));

    expect(result.todos[0].isCompleted, equals(false));
  });

  test('completing todo', () {
    var appState = AppState((b) => b..todos = ListBuilder([todo]));

    AppState result = appReducer(appState, CompleteTodo(todo));

    expect(result.todos[0].isCompleted, equals(true));
  });

  test('reopening todo', () {
    todo = Todo((b) => b
      ..name = '_'
      ..isCompleted = true);
    var appState = AppState((b) => b..todos = ListBuilder([todo]));

    AppState result = appReducer(appState, ReopenTodo(todo));

    expect(result.todos[0].isCompleted, equals(false));
  });

  test('deleting todo', () {
    var appState = AppState((b) => b..todos = ListBuilder([todo]));

    AppState result = appReducer(appState, DeleteTodo(todo));

    expect(result.todos, equals([]));
  });

  test('editing todo', () {
    var appState = AppState((b) => b..todos = ListBuilder([todo]));

    var newTodo = Todo((b) => b..name = 'Do sit up');
    AppState result = appReducer(appState, EditTodo(todo, newTodo));

    expect(result.todos[0], equals(newTodo));
  });

  test('loading todos', () {
    AppState result = appReducer(appState, LoadTodos([todo]));

    expect(result.todos, [todo]);
  });
}
