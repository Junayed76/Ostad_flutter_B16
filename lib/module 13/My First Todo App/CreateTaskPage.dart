import 'package:flutter/material.dart';
class CreateTaskPage extends StatelessWidget {
    CreateTaskPage({super.key});

  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Form(child: Center(
            child: Padding(padding: EdgeInsets.all(16),
            child: TextFormField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'Task',
                filled: true,
                fillColor: Colors.green[50],
              ),
            ),
            )
          )),ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[100]
              ),
              onPressed: (){
            Navigator.pop(context,taskController.text);
          }, child: Text('Add',style: TextStyle(fontWeight: FontWeight.bold),))
        ],
      ),
    );
  }
}
