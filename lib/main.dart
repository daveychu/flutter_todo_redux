import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_todo_redux/redux.dart';
import 'package:redux/redux.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState(BuiltList.of([
      Todo('Do push up'),
      Todo('Do sit up'),
    ])),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: this.store,
      child: MaterialApp(
        title: 'Flutter Todo Redux',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Todo Redux'),
      ),
      body: StoreConnector<AppState, List<Todo>>(
        converter: (store) => store.state.todos.toList(),
        builder: (context, todos) => ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            var todo = todos[index];
            return ListTile(
              leading: Checkbox(
                onChanged: (value) => value
                    ? store.dispatch(CompleteTodo(todo))
                    : store.dispatch(ReopenTodo(todo)),
                value: todo.isCompleted,
              ),
              title: Text(
                todo.name,
                style: TextStyle(
                    decoration: todo.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add todo',
        child: Icon(Icons.add),
      ),
    );
  }
}
