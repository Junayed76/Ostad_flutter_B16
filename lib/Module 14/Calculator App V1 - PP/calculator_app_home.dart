import 'package:flutter/material.dart';

class CalculatorAppHome extends StatefulWidget {
  const CalculatorAppHome({super.key});

  @override
  State<CalculatorAppHome> createState() => _CalculatorAppHomeState();
}

class _CalculatorAppHomeState extends State<CalculatorAppHome> {

  //

  String calc = '';
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
        calc = '';
      });
    } else if (buttonText == '=') {
      calculate();
    }
  }

  ///Screen UI area
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
          title: const Text('GEN-Z FAST',style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),),
        toolbarHeight: 90,
        elevation: 6,
        shadowColor: Colors.greenAccent,
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Column(
        children: [
          //Output Display Area
          Container(
            margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 54, horizontal: 12),
            //color: Colors.white,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              //color: Colors.black,
            ),
            child: Text(
              calc,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 70,
                color: Colors.white,
              ),
            ),
          ),
          Divider(),
          SizedBox(height: 30,),
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
        padding: EdgeInsets.all(6),

        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(14),
            elevation: 2,
            shadowColor: Colors.greenAccent,
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(110),
            ),
          ),
          onPressed: () {
            pressedButton(buttonText);
          },
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 40),
          ),
        ),
      ),
    );
  }
}
