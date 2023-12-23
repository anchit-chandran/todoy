// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 4, 223, 33)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo-y!"),
      ),
      body: TodoForm(),
    );
  }
}

// Define a custom Form widget.
class TodoForm extends StatefulWidget {
  const TodoForm({super.key});

  @override
  State<TodoForm> createState() => _TodoFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _TodoFormState extends State<TodoForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  var todoList = ['Walk the dog', 'Learn flutter', 'Play cs'];

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next step.
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Enter your to-do:"),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Learn flutter...",
              ),
              controller: myController,
            ),
          ),
          for (var todoItem in todoList)
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                todoItem,
                style: TextStyle(backgroundColor: Color(0xD21187CB))
              )
            )
        ],
      ),
    );
  }
}
