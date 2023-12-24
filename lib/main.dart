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
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 230, 5, 83)),

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
  var todos = [
    'Learn flutter',
  ];

  TextEditingController textController = TextEditingController();

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  // fn will grab textFromChild and create a new todo and append it to todos
  void createNewTodo() {
    setState(() {
      String newTodo = textController.text;

      if (newTodo.isEmpty) {
        return;
      }

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Todoy!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black87,
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(children: [
                AnimatedList(
                  key: listKey,
                  initialItemCount: todos.isEmpty ? 1 : todos.length,
                  itemBuilder: (context, index, animation) =>
                      buildTodo(todos[index], animation),
                ),
                Visibility(
                  visible: todos.isEmpty,
                  child: Center(
                    child: Text(
                      "You're done for the day! ☀️",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                )
              ]),
            ),
            SearchBox(
              controller: textController,
              onSubmit: createNewTodo,
            ),
          ],
        ),
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
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Add your todo...',
                    labelStyle: TextStyle(
                        color: Colors
                            .black), // Style for label when it is above the TextField
                    floatingLabelStyle: TextStyle(
                      color: Color.fromARGB(255, 74, 74, 74),
                      backgroundColor: Colors.white,
                    ), // Style for label when it is floating

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      // Border color when TextField is enabled but not focused
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: const Color.fromARGB(255, 113, 113, 113)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // Border color when TextField is focused
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 156, 32, 32)),
                    ),
                  )),
            ),
            IconButton(
              onPressed: onSubmit,
              icon: Icon(Icons.arrow_upward_rounded),
              color: Colors.red,
            )
          ],
        ));
  }
}
