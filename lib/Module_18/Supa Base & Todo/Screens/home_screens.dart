import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'completed_task.dart';
import 'new_task.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  // Variables and methods for HomeScreens can be added here

  final supabase = Supabase.instance.client;
  addToSupa(String data) async {
    try {
      await supabase.from('task table').insert({'task': data});
    } catch (e) {
      print(e);
    }
  }

  static List<String> completedTasks = [];
  static List<String> newTasks = [];

  TextEditingController newTaskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Column(
            children: [
              Text(
                "Home Screens",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Welcome to Home Screens",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
          centerTitle: false,

          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.logout),
            ),
          ],

          bottom: (TabBar(
            tabs: [
              Tab(
                child: Text('New Tasks', style: TextStyle(color: Colors.white)),
              ),
              Tab(
                child: Text(
                  'Completed Tasks',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )),
        ),

        body: TabBarView(
          children: [
            NewTask(newTasks: newTasks, completedTasks: completedTasks),
            CompletedTask(completedTasks: completedTasks),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Add New Task"),
                  content: TextField(
                    controller: newTaskController,
                    decoration: InputDecoration(
                      hintText: "Enter task description",
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          newTasks.add(newTaskController.text);
                          addToSupa(newTaskController.text);
                          newTaskController.clear();
                          Navigator.of(context).pop();
                        });
                      },
                      child: Text("Add"),
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
