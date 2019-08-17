import 'package:built_value/built_value.dart';
import 'package:flutter_todo_redux/todo.dart';
import 'package:built_collection/built_collection.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  BuiltList<Todo> get todos;

  AppState._();

  factory AppState.initial() {
    return _$AppState((b) => b..todos = ListBuilder([]));
  }

  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;
}
