import 'package:b16/Module%2020/Assignment/Screens/newtask_page.dart';

import '../../../Module 20/Assignment/System/api_service.dart';
import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  List<Map<String, String>> newTask = [];
  final VoidCallback updateTaskCount;
  AddTaskPage({super.key,required this.updateTaskCount});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final taskNameController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: taskNameController,
              decoration: InputDecoration(hintText: 'Task Name'),
            ),
            TextFormField(
              controller: taskDescriptionController,
              decoration: InputDecoration(hintText: 'Task Description'),
            ),
            ElevatedButton(
              onPressed: ()  {
                 apiService.newTask(
                  taskNameController.text,
                  taskDescriptionController.text,
                );
                 widget.updateTaskCount();
                taskNameController.clear();
                taskDescriptionController.clear();
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
