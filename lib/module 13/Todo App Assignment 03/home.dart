import 'CreateTaskPage.dart';

import 'package:flutter/material.dart';


class home extends StatefulWidget {
  @override
  State<home> createState() => _HomeState();
}

class _HomeState extends State<home> {
  List<String> tasks = [];
  List<String> doneTasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple To-Do',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),elevation: 6,shadowColor: Colors.black,
           ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Task: ${tasks.length}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  child: ListTile(
                    title: Text(tasks[index]),
                    trailing: TextButton(
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

          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Completed Tasks: ${doneTasks.length}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 12),

          Expanded(
            child: ListView.builder(
              itemCount: doneTasks.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.green[50],
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  child: ListTile(
                    title: Text(doneTasks[index]),
                    leading: Icon(Icons.check_circle, color: Colors.green),
                  ),
                );
              },
            ),
          ),
        ],

        //Eita use kore screen e show koabe Tasks er moddhe ki ki ase
      ),
      bottomNavigationBar: Card(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[100]
          ),
          onPressed: () {

              setState(() {
                doneTasks.clear();
              });

          },
          child: Text(
            'Clear All',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13,color: Colors.black45),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTaskPage()),
          );
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
