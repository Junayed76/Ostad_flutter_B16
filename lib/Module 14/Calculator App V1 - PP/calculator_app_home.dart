import 'package:flutter/material.dart';

class CalculatorAppHome extends StatefulWidget {
  const CalculatorAppHome({super.key});

  @override
  State<CalculatorAppHome> createState() => _CalculatorAppHomeState();
}

class _CalculatorAppHomeState extends State<CalculatorAppHome> {
  //

  String calc = '0';
  int ans = 0;
  int a = 0;
  int b = 0;
  List<String> ops = ['+', '-', '*', '/'];
  void calculate() {
    for (var o in ops) {
      if (calc.contains(o)) {
        List numbs = calc.split(o);
        a = int.parse(numbs[0]);
        b = int.parse(numbs[1]);
        switch (o) {
          case '+':
            ans = (a + b);
            break;
          case '-':
            ans = (a - b);
            break;
          case '*':
            ans = (a * b);
            break;
          case '/':
            ans = (a / b).toInt();
            break;
        }
        setState(() {
          calc = '$ans';
        });
      }
    }
  }

  //Logic Part
  void pressedButton(String buttonText) {
    if (buttonText != '=' && buttonText != 'C') {
      if (ops.contains(buttonText)) {
        // Multi operator tracking check
        bool hasOp = ops.any((op) => calc.contains(op));
        if (hasOp) {
          calculate();
        }
      }
      /*for (var o in ops) {
        if (buttonText == o) {
          if (calc.contains('+') ||
              calc.contains('-') ||
              calc.contains('*') ||
              calc.contains('/')) {
            setState(() {
              calculate();
            });
          }
        }
      }*/

      setState(() {
        calc += buttonText;
      });
    } else if (buttonText == 'C') {
      setState(() {
        calc = '0';
      });
    } else if (buttonText == '=') {
      calculate();
    }
  }

  ///Screen UI area
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          //Output Display Area
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            color: Colors.white,
            child: Text(
              calc,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Colors.black,
              ),
            ),
          ),
          Divider(),
          //Number pad area
          Column(
            children: [
              Row(
                children: [
                  buildButton('+', Colors.orangeAccent),
                  buildButton('-', Colors.orangeAccent),
                  buildButton('/', Colors.orangeAccent),
                  buildButton('*', Colors.orangeAccent),
                ],
              ),
              Row(
                children: [
                  buildButton('7', Colors.white),
                  buildButton('8', Colors.white),
                  buildButton('9', Colors.white),
                  buildButton('0', Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton('4', Colors.white),
                  buildButton('5', Colors.white),
                  buildButton('6', Colors.white),
                  buildButton('C', Colors.orangeAccent),
                ],
              ),
              Row(
                children: [
                  buildButton('1', Colors.white),
                  buildButton('2', Colors.white),
                  buildButton('3', Colors.white),
                  buildButton('=', Colors.greenAccent),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  //Button Widget
  Widget buildButton(String buttonText, Color buttonColor) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),

        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(30),
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(100),
            ),
          ),
          onPressed: () {
            pressedButton(buttonText);
          },
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
