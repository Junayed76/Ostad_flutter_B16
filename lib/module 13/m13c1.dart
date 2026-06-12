import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'SecondPage.dart';
void main(){
  runApp(Lala());
}
class Lala extends StatefulWidget {
  const Lala({super.key});

  @override
  State<Lala> createState() => _LalaState();
}

class _LalaState extends State<Lala> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [


          ],
        ),
      ),
    );
  }
}
