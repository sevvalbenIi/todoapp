import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List toDoList =  []
  ;



  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadToDoList();
  }

  void checkBoxChanged(int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
    _saveToDoList();
  }

  void saveNewTask() {
    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    _saveToDoList();
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
    _saveToDoList();
  }

  Future<void> _loadToDoList() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todoString = prefs.getString('toDoList');
    if (todoString != null) {
      setState(() {
        toDoList = json.decode(todoString);
      });
    }
  }

  Future<void> _saveToDoList() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('toDoList', json.encode(toDoList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 208, 197),
      appBar: AppBar(
        title: const Text("To Do"),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 248, 100, 55),
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.deepOrange[300],
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (BuildContext context, index) {
          return TodoList(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxChanged(index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:20,
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Add New Todo Items",
                  filled: true,
                  fillColor: Colors.deepOrange[200],
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.deepOrange),
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepOrange),
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          ),
          FloatingActionButton(
              onPressed: saveNewTask,
              child: const Icon(Icons.add)),
        ],
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({super.key, 
  required this.taskName, 
  required this.taskCompleted, 
  required this.onChanged,
  required this.deleteFunction,

  
  });

  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.only(
                top: 20, left: 20, right: 20, bottom: 0,), 
                //Todo ayrımı için
              child: Slidable(
                endActionPane: ActionPane(
                  motion: const StretchMotion(), 
                  children: [
                    SlidableAction(
                      onPressed: deleteFunction,
                      icon: Icons.delete,
                      borderRadius: BorderRadius.circular(15),
                      backgroundColor: Colors.red,
                    ),
                  ],
                   ),
                child: Container(
                    //kutu
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange[300],
                    borderRadius: BorderRadius.circular(15),
                     ),
                   
                  child: Row(
                    children: [
                      Checkbox(
                      value: taskCompleted, 
                      onChanged: onChanged,
                      checkColor: const Color.fromARGB(255, 238, 198, 192),
                      activeColor: const Color.fromARGB(255, 255, 94, 45),
                      side: const BorderSide(color: Color.fromARGB(255, 255, 94, 45),),
                      ),
                      Text( 
                        taskName,
                        style: 
                        TextStyle(
                          color:const  Color.fromARGB(255, 238, 198, 192),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          decoration: taskCompleted
                          ? TextDecoration.lineThrough 
                          : TextDecoration.none,
                        decorationColor: Colors.white,
                        decorationThickness: 2,
                        ),
                        
                        ),
                    ],
                  ),
                ),
              ),
            );
  }
}