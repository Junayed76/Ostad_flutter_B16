import 'package:flutter/material.dart';
import 'addtask_page.dart';
import 'newtask_page.dart';
import 'progress_page.dart';
import 'completetask_page.dart';
import 'profile_page.dart';
import '../../../Module 20/Assignment/System/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*late int newTasks ;
  late int progressTask;
  late int completedTasks;*/
  final ApiService apiService = ApiService();

   int newTaskList = 0;
   int progTaskList = 0;
   int compTaskList =0;

  initState() {
    super.initState();
    countTask();
  }

  countTask() async {
    final newTask = await apiService.readNewTask();
    final progTask = await apiService.readProgressTask();
    final CompTask = await apiService.readCompletedTask();
    setState(() {
      newTaskList = newTask!.length;
      progTaskList = progTask!.length;
      compTaskList = CompTask!.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Supa Todo'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list_alt), text: 'New Task($newTaskList)'),
              Tab(
                icon: Icon(Icons.pending_actions),
                text: 'Progress($progTaskList)',
              ),
              Tab(icon: Icon(Icons.add), text: 'Add'),
              Tab(
                icon: Icon(Icons.done_outline),
                text: 'Completed($compTaskList)',
              ),
              Tab(icon: Icon(Icons.account_box), text: 'Profile'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NewTaskPage(updateTaskCount: countTask,),
            ProgressPage(updateTaskCount: countTask,),
            AddTaskPage(updateTaskCount: countTask,),
            CompleteTaskPage(updateTaskCount: countTask,),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
