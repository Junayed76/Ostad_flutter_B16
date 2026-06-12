import 'package:flutter/material.dart';

void main() {
  runApp(Lotus());
}

class Lotus extends StatefulWidget {
  const Lotus({super.key});

  @override
  State<Lotus> createState() => _LotusState();
}

class _LotusState extends State<Lotus> {
  double x = 0;
  double y = 0;
  double scale = 100;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            GestureDetector(
              onPanUpdate: (value){
                setState(() {
                  x += value.delta.dx;
                  y += value.delta.dy;
                });

              },child: Transform.translate(offset: Offset(x,y),
            child: Container(
              width: 10,height: 10,color: Colors.blue,
            ),),
            )
          ],
        ),
      ),
    );
  }
}
