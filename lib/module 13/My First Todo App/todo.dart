import 'package:flutter/material.dart';
import 'home.dart';
void main() {
  runApp(Todo());
}

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: home());
  }
}
