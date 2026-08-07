import 'package:flutter/material.dart';
import '../../../Module 20/Assignment/System/api_service.dart';

class ProgressPage extends StatefulWidget {
  final VoidCallback updateTaskCount;
  const ProgressPage({super.key, required this.updateTaskCount});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  List<Map<String, dynamic>> progressTaskList = [];
  final ApiService apiService = ApiService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProgressTask();
  }

  loadProgressTask() async {
    final result = await apiService.readProgressTask();
    if (result != null) {
      setState(()  {
        progressTaskList = result;
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
                itemCount: progressTaskList.length,
                itemBuilder: (context, index) {
                  final task = progressTaskList[index];
                  return Card(
                    color: Colors.redAccent,
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
                              // Add to Complete task table <write>
                              await apiService.writeCompletedTask(
                                task['task_name'],
                                task['task_desc'],
                                task['id'],
                              );
                              await apiService.deleteProgressTask(task['id']);
                              widget.updateTaskCount();
                              loadProgressTask();
                            },
                            icon: Icon(Icons.done),
                          ),
                          SizedBox(width: 8),
                          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                          SizedBox(width: 8),
                          IconButton(
                            onPressed: () async{
                              // Delete from Progress task table <delete>
                              await apiService.deleteProgressTask(task['id']);
                              widget.updateTaskCount();
                              loadProgressTask();
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
