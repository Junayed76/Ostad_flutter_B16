
import 'package:flutter/material.dart';
import 'calculator_app_home.dart';

void main (){
  runApp(Calculator());
}
class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorAppHome(),
    );
  }
}
