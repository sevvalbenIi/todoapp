import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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


