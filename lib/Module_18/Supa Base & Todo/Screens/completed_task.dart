import 'package:flutter/material.dart';

class CompletedTask extends StatefulWidget {


  List<String>? completedTasks = [];
  CompletedTask({super.key, this.completedTasks});

  @override
  State<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {
  //Variables and methods for CompletedTask can be added here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: widget.completedTasks == null
            ?Center(child: Text("No completed tasks yet.")): Card(
                color: Colors.white70,
                child: ListView.builder(
                  itemCount: widget.completedTasks!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        "Completed Task ${widget.completedTasks![index]}",
                      ),
                      subtitle: Text("Status"),
                    );
                  },
                ),
              )
      ),
    );
  }
}
