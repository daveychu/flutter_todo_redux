import 'package:built_collection/built_collection.dart';
import 'package:flutter_todo_redux/app_state.dart';
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
  return appState
      .rebuild((b) => b..todos = todosReducer(appState.todos, action));
}

ListBuilder<Todo> todosReducer(BuiltList<Todo> todos, action) {
  if (action is AddTodo) {
    return ListBuilder(todos.toList()..add(action.todo));
  } else if (action is CompleteTodo) {
    return ListBuilder(todos.map((todo) => todo == action.todo
        ? todo.rebuild((b) => b..isCompleted = true)
        : todo));
  } else if (action is ReopenTodo) {
    return ListBuilder(todos.map((todo) => todo == action.todo
        ? todo.rebuild((b) => b..isCompleted = false)
        : todo));
  } else if (action is DeleteTodo) {
    return ListBuilder(
        todos.toList()..removeWhere((todo) => todo == action.todo));
  } else if (action is EditTodo) {
    return ListBuilder(todos
        .toList()
        .map((todo) => todo == action.todo ? action.newTodo : todo));
  } else if (action is LoadTodos) {
    return ListBuilder(action.todos.toList());
  }
  return todos.toBuilder();
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
