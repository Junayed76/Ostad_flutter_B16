import 'package:flutter/material.dart';

class inputPage extends StatefulWidget {
  const inputPage({super.key});

  @override
  State<inputPage> createState() => _inputPageState();
}

class _inputPageState extends State<inputPage> {
  TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child:
              //Input field where users input their task
              TextFormField(
                controller: inputController,
                decoration: InputDecoration(
                  labelText: 'New Task',
                  filled: true,
                  fillColor: Colors.green[50],
                ),
              ),
            ),
          ),
          //Button that send new task
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              backgroundColor: Colors.green[200],
              elevation: 10,
              shadowColor: Colors.black12,
            ),
            onPressed: () {
              setState(() {
                //System that send data
                Navigator.pop(context, inputController.text);
              });
            },
            child: Text(
              'Add Task',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
