import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  List<String> newTasks = [];
  List<String> completedTasks = [];
  NewTask({super.key, required this.newTasks, required this.completedTasks});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  //Variables and methods for NewTask can be added here


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Card(
          color: Colors.white70,
          child: ListView.builder(
            itemCount: widget.newTasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("Task ${widget.newTasks[index]}"),
                subtitle: Text("Status"),
                trailing: Checkbox(
                  value: false,
                  onChanged: (value) {
                    setState(() {
                      //addToCompletedTasks(widget.newTasks[index]);
                      widget.completedTasks.add(widget.newTasks[index]);
                      widget.newTasks.removeAt(index);
                    });
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
