import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_todo_redux/local_json_storage.dart';
import 'package:flutter_todo_redux/todo.dart';
import 'package:flutter_todo_redux/redux.dart';
import 'package:flutter_todo_redux/todo_repository.dart';
import 'package:redux/redux.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [TodosPersistenceMiddleware(TodoRepository(LocalJsonStorage()))],
  )..dispatch(LoadTodos());

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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => EditTodoScreen(todo))),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => store.dispatch(DeleteTodo(todo)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EditTodoScreen())),
        tooltip: 'Add todo',
        child: Icon(Icons.add),
      ),
    );
  }
}

class EditTodoScreen extends StatefulWidget {
  final Todo todo;

  EditTodoScreen([this.todo]);

  @override
  _EditTodoScreenState createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.todo?.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              controller: nameController,
            ),
            RaisedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  var newTodo = Todo((b) => b..name = nameController.text);
                  var store = StoreProvider.of<AppState>(context);
                  if (widget.todo != null) {
                    store.dispatch(EditTodo(widget.todo, newTodo));
                  } else {
                    store.dispatch(AddTodo(newTodo));
                  }
                }
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
