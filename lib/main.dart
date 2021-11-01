import 'package:flutter/material.dart';
import "package:hive/hive.dart";
import 'package:hive_demo/boxes.dart';
import 'package:hive_demo/models/todo.dart';
import "package:hive_flutter/hive_flutter.dart";

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());

  await Hive.openBox<Todo>("todos");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  Future addTodo() async {
    final todo = Todo(id: 1, text: _controller.text);

    final box = Boxes.getTodos();
    box.add(todo);
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: "Enter todo title"),
            ),
            ValueListenableBuilder<Box<Todo>>(
                valueListenable: Boxes.getTodos().listenable(),
                builder: (context, box, _) {
                  final todos = box.values.toList().cast<Todo>();

                  return Expanded(
                    child: ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        print(todos[0].text);
                        return ListTile(
                          title: Text(todos[index].text),
                        );
                      },
                    ),
                  );
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        tooltip: 'Add todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
