import 'package:flutter/material.dart';
import 'todoHome.dart';

void main(){
  runApp(myTodo());
}
class myTodo extends StatefulWidget {
  const myTodo({super.key});

  @override
  State<myTodo> createState() => _myTodoState();
}

class _myTodoState extends State<myTodo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: todoHome(),
    );
  }
}
