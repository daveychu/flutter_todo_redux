import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_redux/redux.dart';

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
