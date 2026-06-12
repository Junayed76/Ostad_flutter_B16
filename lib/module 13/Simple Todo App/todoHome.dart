import 'package:flutter/material.dart';
import 'inputPage.dart';

class todoHome extends StatefulWidget {
  const todoHome({super.key});

  @override
  State<todoHome> createState() => _todoHomeState();
}

class _todoHomeState extends State<todoHome> {
  //Pending task & completed task er data store area
  List<String> tasks = [];
  List<String> doneTasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        shadowColor: Colors.black,
        title: Text(
          'Simple Todo',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: Column(
        children: [

          //Title area
          SizedBox(height: 25),
          Text(
            'Tasks Pending: ${tasks.length}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
          ),
          SizedBox(height: 25),

          //Pending tasks list display area
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.green,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    //Display the task
                    title: Text(tasks[index]),
                    trailing:
                    //Button that add completed task to doneTasks list
                    TextButton(
                      onPressed: () {
                        setState(() {
                          doneTasks.add(tasks[index]);
                          tasks.removeAt(index);
                        });
                      },
                      child: Icon(Icons.check_box_outline_blank),
                    ),
                  ),
                );
              },
            ),
          ),

          //Title area
          SizedBox(height: 25),
          Text(
            'Completed Tasks: ${doneTasks.length}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
          ),
          SizedBox(height: 25),

          //Completed tasks list display area
          Expanded(
            child: ListView.builder(
              itemCount: doneTasks.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.green[100],
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    //Display Completed task
                    title: Text(doneTasks[index]),
                    leading: Icon(Icons.done),
                    trailing:
                    //Button that clear completed task from the doneTask List
                    TextButton(
                      onPressed: () {
                        setState(() {
                          doneTasks.removeAt(index);
                        });
                      },
                      child: Icon(Icons.delete),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      //New task adding button area
      floatingActionButton: FloatingActionButton(

        //Open input field page to add new task
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => inputPage()),
          );

          //Logic that add new task to the tasks list
          if (result != null) {
            setState(() {
              tasks.add(result);
            });
          }

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
