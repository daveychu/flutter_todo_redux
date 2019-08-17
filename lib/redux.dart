import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_redux/todo.dart';
import 'package:flutter_todo_redux/todo_repository.dart';
import 'package:redux/redux.dart';

class EditTodo {
  Todo todo;
  Todo newTodo;

  EditTodo(this.todo, this.newTodo);
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

class LoadTodos {
  List<Todo> todos;

  LoadTodos([this.todos]);
}

AppState appReducer(AppState appState, action) {
  if (action is AddTodo) {
    return AppState(BuiltList.of(appState.todos.toList()..add(action.todo)));
  } else if (action is CompleteTodo) {
    return AppState(
        BuiltList.of(appState.todos.map((todo) => todo == action.todo
            ? Todo((b) => b
              ..name = todo.name
              ..isCompleted = true)
            : todo)));
  } else if (action is ReopenTodo) {
    return AppState(
        BuiltList.of(appState.todos.map((todo) => todo == action.todo
            ? Todo((b) => b
              ..name = todo.name
              ..isCompleted = false)
            : todo)));
  } else if (action is DeleteTodo) {
    return AppState(BuiltList.of(
        appState.todos.toList()..removeWhere((todo) => todo == action.todo)));
  } else if (action is EditTodo) {
    return AppState(BuiltList.of(appState.todos
        .toList()
        .map((todo) => todo == action.todo ? action.newTodo : todo)));
  } else if (action is LoadTodos) {
    return AppState(BuiltList.of(action.todos));
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

class TodosPersistenceMiddleware extends MiddlewareClass<AppState> {
  TodoRepository todoRepository;

  TodosPersistenceMiddleware(this.todoRepository);

  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadTodos) {
      next(LoadTodos(await todoRepository.loadTodos()));
    } else {
      next(action);
      todoRepository.saveTodos(store.state.todos.toList());
    }
  }
}
