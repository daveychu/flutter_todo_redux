library serializers;

import 'package:built_value/serializer.dart';
import 'package:flutter_todo_redux/todo.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Todo,
])
final Serializers serializers = _$serializers;
