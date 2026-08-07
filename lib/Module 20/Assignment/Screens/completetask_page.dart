import 'package:flutter/material.dart';
import '../../../Module 20/Assignment/System/api_service.dart';


class CompleteTaskPage extends StatefulWidget {
  final VoidCallback updateTaskCount;
  const CompleteTaskPage({super.key,required this.updateTaskCount});

  @override
  State<CompleteTaskPage> createState() => _CompleteTaskPageState();
}

class _CompleteTaskPageState extends State<CompleteTaskPage> {
  List<Map<String, dynamic>> completeTaskList = [];

  final ApiService apiService = ApiService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCompleteTask();
  }

  loadCompleteTask() async {
    final result = await apiService.readCompletedTask();
    if (result != null) {
      setState(()  {
        completeTaskList = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: completeTaskList.length,
                itemBuilder: (context, index) {
                  final task = completeTaskList[index];
                  return Card(
                    color: Colors.lightGreen.withValues(alpha: 0.5),
                    child: ListTile(
                      title: Text('${index+1}. ${task['task_name']}'),
                      subtitle: Text('${task['task_desc']}',softWrap: true,maxLines: 3,),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: () async{
                            // Delete from Complete task table <delete>
                            await apiService.deleteCompletedTask(task['id']);
                            widget.updateTaskCount();
                            loadCompleteTask();
                          }, icon: Icon(Icons.delete)),
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
