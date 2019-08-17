// GENERATED CODE - DO NOT MODIFY BY HAND

part of todo;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Todo> _$todoSerializer = new _$TodoSerializer();

class _$TodoSerializer implements StructuredSerializer<Todo> {
  @override
  final Iterable<Type> types = const [Todo, _$Todo];
  @override
  final String wireName = 'Todo';

  @override
  Iterable<Object> serialize(Serializers serializers, Todo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'isCompleted',
      serializers.serialize(object.isCompleted,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  Todo deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TodoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isCompleted':
          result.isCompleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$Todo extends Todo {
  @override
  final String name;
  @override
  final bool isCompleted;

  factory _$Todo([void Function(TodoBuilder) updates]) =>
      (new TodoBuilder()..update(updates)).build();

  _$Todo._({this.name, this.isCompleted}) : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('Todo', 'name');
    }
    if (isCompleted == null) {
      throw new BuiltValueNullFieldError('Todo', 'isCompleted');
    }
  }

  @override
  Todo rebuild(void Function(TodoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TodoBuilder toBuilder() => new TodoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Todo &&
        name == other.name &&
        isCompleted == other.isCompleted;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, name.hashCode), isCompleted.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Todo')
          ..add('name', name)
          ..add('isCompleted', isCompleted))
        .toString();
  }
}

class TodoBuilder implements Builder<Todo, TodoBuilder> {
  _$Todo _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  bool _isCompleted;
  bool get isCompleted => _$this._isCompleted;
  set isCompleted(bool isCompleted) => _$this._isCompleted = isCompleted;

  TodoBuilder();

  TodoBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _isCompleted = _$v.isCompleted;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Todo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Todo;
  }

  @override
  void update(void Function(TodoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Todo build() {
    final _$result = _$v ?? new _$Todo._(name: name, isCompleted: isCompleted);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
