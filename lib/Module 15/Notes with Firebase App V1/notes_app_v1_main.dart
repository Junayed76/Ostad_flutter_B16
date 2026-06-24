import 'notes_app_v1_home.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(NotesAppV1());
}

class NotesAppV1 extends StatelessWidget {
  const NotesAppV1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes JI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
      ),
      home: NotesAppV1Home()
    );
  }
}
