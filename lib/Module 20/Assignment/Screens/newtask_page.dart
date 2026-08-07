import 'package:flutter/material.dart';
import '../../../Module 20/Assignment/System/api_service.dart';

class NewTaskPage extends StatefulWidget {
  final VoidCallback updateTaskCount;
  const NewTaskPage({super.key,required this.updateTaskCount});


  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final ApiService apiService = ApiService();
  List<Map<String, dynamic>> newTaskList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTask();
  }


  loadTask() async {
    final result = await apiService.readNewTask();
    if (result != null) {
      setState(()  {
        newTaskList = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: newTaskList.length,
                itemBuilder: (context, index) {
                  final task = newTaskList[index];
                  return Card(
                    color: Colors.lightGreen,
                    child: ListTile(
                      title: Text('${index+1}. ${task['task_name']}'),
                      subtitle: Text(
                        '${task['task_desc']}',
                        softWrap: true,
                        maxLines: 3,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async{
                              await apiService.writeProgressTask(
                                task['task_name'],
                                task['task_desc'],
                                task['id'],
                              );
                              await apiService.deleteTask(task['id']);
                              widget.updateTaskCount();
                              loadTask();
                            },
                            icon: Icon(Icons.run_circle),
                          ),
                          SizedBox(width: 8),
                          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                          SizedBox(width: 8),
                          IconButton(
                            onPressed: () async{
                              await apiService.deleteTask(task['id']);
                              widget.updateTaskCount();
                              loadTask();
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
