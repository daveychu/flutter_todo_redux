library todo;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_todo_redux/serializers.dart';

part 'todo.g.dart';

abstract class Todo implements Built<Todo, TodoBuilder> {
  Todo._();

  factory Todo([updates(TodoBuilder b)]) => _$Todo((b) => b
    ..isCompleted = false
    ..update(updates));

  @BuiltValueField(wireName: 'name')
  String get name;

  @BuiltValueField(wireName: 'isCompleted')
  bool get isCompleted;

  String toJson() {
    return json.encode(serializers.serializeWith(Todo.serializer, this));
  }

  static Todo fromJson(String jsonString) {
    return serializers.deserializeWith(
        Todo.serializer, json.decode(jsonString));
  }

  static Serializer<Todo> get serializer => _$todoSerializer;
}
