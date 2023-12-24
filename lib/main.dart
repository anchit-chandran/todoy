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
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var todos = ['Learn flutter', 'Have fun', "Revise"];

  TextEditingController textController = TextEditingController();

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  // fn will grab textFromChild and create a new todo and append it to todos
  void createNewTodo() {
    setState(() {
      String newTodo = textController.text;
      int index = todos.isNotEmpty ? todos.length : 0;
      todos.add(newTodo);
      listKey.currentState!.insertItem(index);
      textController.clear(); // clear the input box on submit
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  // This function renders a todo inside a card
  Widget renderTodo(String todo) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(todo),
              IconButton(
                  onPressed: () {
                    setState(() {
                      int index = todos.indexOf(todo);
                      if (index != -1) {
                        todos.removeAt(index);
                        listKey.currentState!.removeItem(
                          index,
                          (context, animation) => buildTodo(todo, animation),
                          duration: const Duration(
                              milliseconds:
                                  250), // Set a suitable duration for the animation
                        );
                      }
                    });
                  },
                  icon: Icon(Icons.circle_outlined)),
            ],
          ),
        ),
      ),
    );
  }

  // this function builds animation for todo list
  Widget buildTodo(String item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: renderTodo(item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todoy!')),
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: listKey,
              initialItemCount: todos.length,
              itemBuilder: (context, index, animation) {
                if (todos.isNotEmpty) {
                  return buildTodo(todos[index], animation);
                } else {
                  return Center(
                      child: Text("You're done for the day! ☀️",
                          style: TextStyle(
                            fontSize: 20,
                          )));
                }
              },
            ),
          ),
          SearchBox(
            controller: textController,
            onSubmit: createNewTodo,
          ),
        ],
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  final void Function() onSubmit;
  final TextEditingController controller;

  const SearchBox({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      labelText: 'Add your todo...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(),
                      ))),
            ),
            IconButton(
              onPressed: onSubmit,
              icon: Icon(Icons.arrow_upward),
            )
          ],
        ));
  }
}
